module PivotalTracker
  class Story
    include Virtusable
    include Validation

    class << self
      def all(project, options={})
        params = PivotalTracker.encode_options(options)
        stories = parse(Client.connection["/projects/#{project['id']}/stories#{params}"].get)
        stories.each { |s| s['project_id'] = project['id'] }
        return stories
      end

      def find(param, project_id)
        begin
          story = parse(Client.connection["/projects/#{project_id}/stories/#{param}"].get)
          story.project_id = project_id
        rescue RestClient::ExceptionWithResponse
          story = nil
        end
        return story
      end
    end

    attribute :name, String
    attribute :url, String
    attribute :current_state, String
    attribute :story_type, String
    attribute :kind, String
    attribute :owned_by_id, Integer
    attribute :id, Integer
    attribute :project_id, Integer
    attribute :description, String
    attribute :owner_ids, Array[Integer]
    attribute :accepted_at, DateTime
    attribute :updated_at, DateTime
    attribute :requested_by_id, Integer
    attribute :created_at, DateTime
    attribute :labels, Array[Label]

    def create
      return self if project_id.nil?
      response = Client.connection["/projects/#{project_id}/stories"].post(self.to_xml, :content_type => 'application/xml')
      new_story = Story.parse(response)
      new_story.project_id = project_id
      return new_story
    end

    def update(attrs={})
      update_attributes(attrs)
      response = Client.connection["/projects/#{project_id}/stories/#{id}"].put(self.to_xml, :content_type => 'application/xml')
      return Story.parse(response)
    end

    def move(position, story)
      raise ArgumentError, "Can only move :before or :after" unless [:before, :after].include? position
      Story.parse(Client.connection["/projects/#{project_id}/stories/#{id}/moves?move\[move\]=#{position}&move\[target\]=#{story.id}"].post(''))
    end

    def delete
      Client.connection["/projects/#{project_id}/stories/#{id}"].delete
    end

    def notes
      @notes ||= Proxy.new(self, Note)
    end

    def tasks
      @tasks ||= Proxy.new(self, Task)
    end

    def upload_attachment(filename)
      Attachment.parse(Client.connection["/projects/#{project_id}/stories/#{id}/attachments"].post(:Filedata => File.new(filename)))
    end

    def move_to_project(new_project)
      move = true
      old_project_id = self.project_id
      target_project = -1
      case new_project.class.to_s
        when 'PivotalTracker::Story'
          target_project = new_project.project_id
        when 'PivotalTracker::Project'
          target_project = new_project.id
        when 'String'
          target_project = new_project.to_i
        when 'Fixnum', 'Integer'
          target_project = new_project
        else
          move = false
      end
      if move
        move_builder = Nokogiri::XML::Builder.new do |story|
          story.story {
            story.project_id "#{target_project}"
                  }
        end
        Story.parse(Client.connection["/projects/#{old_project_id}/stories/#{id}"].put(move_builder.to_xml, :content_type => 'application/xml'))
      end
    end
  end
end
