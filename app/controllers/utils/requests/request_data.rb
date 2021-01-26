module Utils
  module Requests
    class RequestData
      attr_reader :headers, :body, :url, :type
    
      def initialize(type = :get, headers, body, url)
        @type = :get
        @headers = headers
        @body = body
        @url = url
      end
    end
  end
end