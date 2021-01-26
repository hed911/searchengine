module Utils
  class HttpRequester
    attr_reader :request_data, :response, :errors
  
    def initialize(request_data)
      @request_data = request_data
    end
  
    def execute
      options = {
        body: @request_data.body,
        headers: {
          'Content-Type': "application/json"
        }.merge(@request_data.headers)
      }
      @valid = true
      begin
        response = Rails.cache.fetch(@request_data.url, expires_in: 1.minute) do
          if @request_data.type == :get
            HTTParty.get(@request_data.url, options).parsed_response
          else
            HTTParty.post(@request_data.url, options).parsed_response
          end
        end
        @response = response
      rescue => e
        puts e.message
        @valid = false
      end
    end

    def valid_response?
      @valid
    end
  end
end