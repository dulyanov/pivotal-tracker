module PivotalTracker
  module Coercion
    class Hashie < Virtus::Attribute
      def coerce(value)
        ::Hashie::Mash.new value
      end
    end
  end
end
