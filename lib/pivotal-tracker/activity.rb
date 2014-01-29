module PivotalTracker
  class Activity
    include Virtusable

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
          options_string << "newer_than_version=#{options.delete(:newer_than_version)}" if options[:newer_than_version]

          if options[:occurred_since]
            options_string << "occurred_since_date=\"#{options[:occurred_since].utc}\""
          elsif options[:occurred_since_date]
            options_string << "occurred_since_date=#{URI.escape options[:occurred_since_date].strftime("%Y/%m/%d %H:%M:%S %Z")}"
          end

          return "?#{options_string.join('&')}"
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
  end
end
