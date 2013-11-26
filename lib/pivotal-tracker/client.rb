module PivotalTracker

  class Client

    class NoToken < StandardError; end

    class << self
      attr_writer :token, :tracker_host

      def token(username, password)
        resource = RestClient::Resource.new("#{api_url}/me", username, password)
        response = resource.get
        json = JSON.parse(response)
        @token = json['api_token']
      end

      # this is your connection for the entire module
      def connection(options={})
        raise NoToken if @token.to_s.empty?

        @connections ||= {}

        cached_connection? ? cached_connection : new_connection
      end

      def clear_connections
        @connections = nil
      end

      def tracker_host
        @tracker_host ||= "www.pivotaltracker.com"
      end

      def api_url
        "https://#{tracker_host}#{api_path}"
      end

      protected

        def cached_connection?
          !@connections[@token].nil?
        end

        def cached_connection
          @connections[@token]
        end

        def new_connection
          @connections[@token] = RestClient::Resource.new(api_url, :headers => {'X-TrackerToken' => @token, 'Content-Type' => 'application/json'})
        end

        def api_path
          '/services/v5'
        end
    end

  end
end
