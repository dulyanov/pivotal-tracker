module PivotalTracker
  class Label
    include Virtusable

    attribute :created_at, DateTime
    attribute :id, Integer
    attribute :kind, String
    attribute :name, String
    attribute :project_id, String
    attribute :updated_at, DateTime
  end
end