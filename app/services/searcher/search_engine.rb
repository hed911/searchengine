module Services
  class SearchEngine
    attr_accessor :request, :response_handler, :result, :valid

    def initialize(request, response_handler)
      @request = request
      @response_handler = response_handler
    end
  
    def fetch_results(options)
      @request.set_config(options)
      requester = Requester.new @request.get_request_data
      requester.execute
      data = @response_handler.parse(requester.response)
      @valid = true
      begin
        @result = ResponseParser.parse(data, @request.id)
      rescue => e
        @valid = false
      end
    end

    def valid?
      @valid
    end
  end
end