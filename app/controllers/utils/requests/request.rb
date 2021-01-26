module Utils
  module Requests
    class Request
      attr_reader :id, :base_url, :url, :text, :headers, :offset, :count, :params
    
      def initialize(text)
        @text = text
        @headers = {}
        @params = {}
        @offset = 0
        @count = DEFAULT_NUMBER_OF_PAGES
      end
    
      def get_request_data
        RequestData.new(:get, @headers, {}, "#{@base_url}?#{@params.to_query}")
      end
    end
  end
end