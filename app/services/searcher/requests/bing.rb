module Services
  module Requests
    class Bing < Request
      def initialize(text)
        super
        @id = 'bing'
        @base_url = "https://api.bing.microsoft.com/v7.0/search"
        @headers["Ocp-Apim-Subscription-Key"] = ENV["bing_api_key"]
        @params[:q] = CGI.escape text
      end
    
      def set_config(options)
        @params[:offset] = options.has_key?(:offset) ? options[:offset] : 0 
        @params[:count] = options.has_key?(:count) ? options[:count] : DEFAULT_NUMBER_OF_PAGES
      end
    end
  end
end
