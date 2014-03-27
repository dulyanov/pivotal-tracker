module PivotalTracker
  class Epic
    include Virtusable
    include Validation

    class << self
      def all(project, options={})
        params = PivotalTracker.encode_options(options)
        epics = parse(Client.connection["/projects/#{project['id']}/epics#{params}"].get)
        epics.each { |s| s['project_id'] = project['id'] }
        return epics
      end

      def find(param, project_id)
        begin
          epic = parse(Client.connection["/projects/#{project_id}/epics/#{param}"].get)
          epic.project_id = project_id
        rescue RestClient::ExceptionWithResponse
          epic = nil
        end
        return epic
      end
    end

    attribute :label_id, Integer
    attribute :id, Integer
    attribute :description, String
    attribute :project_id, Integer
    attribute :kind, String
    attribute :updated_at, DateTime
    attribute :created_at, DateTime
    attribute :url, String
    attribute :name, String
    attribute :follower_ids, Array[Integer]
    attribute :comment_ids, Array[Integer]


    def notes
      @notes ||= Proxy.new(self, Note)
    end

    def tasks
      @tasks ||= Proxy.new(self, Task)
    end

  end
end
