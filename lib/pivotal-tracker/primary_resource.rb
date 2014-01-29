module PivotalTracker
  class PrimaryResource
    include Virtusable

    attribute :id, Integer
    attribute :kind, String
    attribute :name, String
    attribute :story_type, String
    attribute :url, String
  end
end