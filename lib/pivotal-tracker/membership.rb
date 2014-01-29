module PivotalTracker
  class Membership
    include Virtusable

    class << self
      def all(project, options={})
        parse(Client.connection["/projects/#{project.id}/memberships"].get)
      end
    end

    attribute :id, Integer
    attribute :role, String

    # Flattened Attributes from <person>...</person>
    attribute :name, String#, :deep => true
    attribute :email, String#, :deep => true
    attribute :initials, String#, :deep => true

  end
end
