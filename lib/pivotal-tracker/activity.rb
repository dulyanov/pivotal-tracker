module PivotalTracker
  class Activity
    include Virtusable

    RESOURCE_TYPES = %w(comment epic follower iteration label project_membership story task)

    class << self
      def all(project=nil, options={})
        params = self.encode_options(options)
        if project
          parse(Client.connection["/projects/#{project.id}/activity#{params}"].get)
        else
          parse(Client.connection["/my/activity#{params}"].get)
        end
      end

      protected

        def encode_options(options)
          return nil if !options.is_a?(Hash) || options.empty?

          options_string = []
          options_string << "limit=#{options.delete(:limit)}" if options[:limit]
          options_string << "offset=#{options.delete(:offset)}" if options[:offset]
          options_string << "since_version=#{options.delete(:since_version)}" if options[:since_version]
          options_string << "occurred_after=#{parse_date options[:occurred_after]}" if options[:occurred_after]
          options_string << "occurred_before=#{parse_date options[:occurred_before]}" if options[:occurred_before]

          return "?#{options_string.join('&')}"
        end

      private

      def parse_date(date)
        date.to_datetime.strftime('%Q')
      end

    end

    attribute :project_version, Integer
    attribute :project, Hash[String => String]
    attribute :performed_by, Hash[String => String]
    attribute :kind, String
    attribute :guid, String
    attribute :message, String
    attribute :highlight, String
    attribute :changes, Array[PivotalTracker::Change]
    attribute :primary_resources, Array[PivotalTracker::PrimaryResource]
    attribute :occurred_at, DateTime

    def resource_type
      RESOURCE_TYPES.select{|item| kind.include? item}.first
    end

    def action
      kind.gsub("#{resource_type}_","").gsub("_activity","")
    end
  end
end
