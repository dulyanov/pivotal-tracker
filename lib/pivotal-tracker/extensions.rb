# Happymapper patch for RestClient API Change (response => response.body)

module HappyMapper
  module ClassMethods
    alias_method :orig_parse, :parse
    def parse(json, options={})
      json = json.to_s if json.is_a?(RestClient::Response)
      JSON.parse(json)
    end
  end
end