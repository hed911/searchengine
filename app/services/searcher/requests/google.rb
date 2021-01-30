module Services
  module Requests
    class Google < Request
      def initialize(text)
        super
        @id = 'google'
        @base_url = "https://www.googleapis.com/customsearch/v1"
        @params[:key] = ENV["google_api_key"]
        @params[:cx] = ENV["google_search_engine_id"]
        @params[:q] = CGI.escape text
      end
    
      def set_config(options)
        @params[:start] = options.has_key?(:offset) ? options[:offset] : 0 
        @params[:num] = options.has_key?(:count) ? options[:count] : DEFAULT_NUMBER_OF_PAGES
      end
    end
  end
end
