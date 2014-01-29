module PivotalTracker
  class Project
    include Virtusable

    class << self
      def all
        @found = parse(Client.connection['/projects'].get)
      end

      def find(id)
        if @found
          @found.detect { |document| document['id'] == id }
        else
          parse(Client.connection["/projects/#{id}"].get)
        end
      end
    end

    attribute :account_id, Integer
    attribute :atom_enabled, Boolean
    attribute :bugs_and_chores_are_estimatable, Boolean
    attribute :created_at, DateTime
    attribute :current_iteration_number, Integer
    attribute :enable_following, Boolean
    attribute :enable_incoming_emails, Boolean
    attribute :enable_planned_mode, Boolean
    attribute :enable_tasks, Boolean
    attribute :has_google_domain, Boolean
    attribute :id, Integer
    attribute :initial_velocity, Integer
    attribute :iteration_length, Integer
    attribute :kind, String
    attribute :name, String
    attribute :number_of_done_iterations_to_show, Integer
    attribute :point_scale, String
    attribute :point_scale_is_custom, Boolean
    attribute :public, Boolean
    attribute :start_time, DateTime
    attribute :time_zone, Hash[String => String]
    attribute :updated_at, DateTime
    attribute :velocity_averaged_over, Integer
    attribute :version, Integer
    attribute :week_start_day, String

    def create
      response = Client.connection["/projects"].post(self.to_json, :content_type => 'application/json')
      project = Project.parse(response)
      return project
    end

    def activities
      @activities ||= Proxy.new(self, Activity)
    end

    def iterations
      @iterations ||= Proxy.new(self, Iteration)
    end

    def stories
      @stories ||= Proxy.new(self, Story)
    end

    def memberships
      @memberships ||= Proxy.new(self, Membership)
    end

    def iteration(group)
      case group.to_sym
      when :done then Iteration.done(self)
      when :current then Iteration.current(self)
      when :backlog then Iteration.backlog(self)
      when :current_backlog then Iteration.current_backlog(self)
      else
        raise ArgumentError, "Invalid group. Use :done, :current, :backlog or :current_backlog instead."
      end
    end

  end
  class Project
    include Validation
  end
end
