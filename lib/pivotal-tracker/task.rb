module PivotalTracker
  class Task
    include Virtusable
    include Validation

    class << self
      def all(story, options={})
        tasks = parse(Client.connection["/projects/#{story.project_id}/stories/#{story.id}/tasks"].get)
        tasks.each { |t| t.project_id, t.story_id = story.project_id, story.id }
        return tasks
      end
    end

    attr_accessor :project_id, :story_id

    attribute :id, Integer
    attribute :description, String
    attribute :position, Integer
    attribute :complete, Boolean
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :kind, String
    attribute :story_id, Integer

    def create
      response = Client.connection["/projects/#{project_id}/stories/#{story_id}/tasks"].post(self.to_xml, :content_type => 'application/xml')
      return Task.parse(response)
    end

    def update(attr = {})
      update_attributes(attr)
      response = Client.connection["/projects/#{project_id}/stories/#{story_id}/tasks/#{id}"].put(self.to_xml, :content_type => 'application/xml')
      return Task.parse(response)
    end

    def delete
      Client.connection["/projects/#{project_id}/stories/#{story_id}/tasks/#{id}"].delete
    end
  end
end
