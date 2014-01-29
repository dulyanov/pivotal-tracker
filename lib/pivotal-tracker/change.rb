module PivotalTracker
  class Change
    include Virtusable

    attribute :change_type, String
    attribute :kind, String
    attribute :name, String
    attribute :new_values, Coercion::Hashie
    attribute :number, Integer
    attribute :original_values, Coercion::Hashie
    attribute :story_type, String
  end
end