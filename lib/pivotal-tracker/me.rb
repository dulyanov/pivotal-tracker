module PivotalTracker
  class Me
    include Virtusable

    class << self
      def all
        parse(Client.connection["/me"].get)
      end
    end

    attribute :api_token
    attribute :created_at, DateTime
    attribute :email, String
    attribute :has_google_identity, Boolean
    attribute :id, Integer
    attribute :initials, String
    attribute :kind, String
    attribute :name, String
    attribute :projects, Array[Coercion::Hashie]
    attribute :receives_in_app_notifications, Boolean
    attribute :time_zone, Coercion::Hashie
    attribute :updated_at, DateTime
    attribute :username, String
  end
end
