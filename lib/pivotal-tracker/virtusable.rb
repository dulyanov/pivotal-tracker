module Virtusable
  def self.included(base)
    base.send :include, Virtus.model
    base.extend ClassMethods
  end

  module ClassMethods
    def parse(response)
      parsed_response = JSON.parse(response)
      if parsed_response.is_a? Array
        parsed_response.map do |item|
          self.new item
        end
      else
        self.new parsed_response
      end
    end
  end
end