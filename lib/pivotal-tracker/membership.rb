module PivotalTracker
  class Membership
    include Virtusable

    class << self
      def all(project, options={})
        parse(Client.connection["/projects/#{project.id}/memberships"].get)
      end
    end

    attribute :id, Integer
    attribute :kind, String
    attribute :last_viewed_at, DateTime
    attribute :person, Coercion::Hashie
    attribute :project_color, String
    attribute :project_id, Integer
    attribute :role, String
  end
end
