module PivotalTracker
  class Attachment
    include Virtusable

    # tag 'attachment'

    attribute :id, Integer
    attribute :filename, String
    attribute :description, String
    attribute :uploaded_by, String
    attribute :uploaded_at, DateTime
    attribute :url, String
    attribute :status, String

  end
end
