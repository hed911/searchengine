module Utils
  class Factory
    def self.for(type, text)
      case type
      when 'google'
        request = Requests::Google.new(text)
        response_handler = ResponseHandlers::Google.new()
        SearchEngine.new(request, response_handler)
      when 'bing'
        request = Requests::Bing.new(text)
        response_handler = ResponseHandlers::Bing.new()
        SearchEngine.new(request, response_handler)
      else
        raise 'Unsupported type'
      end
    end
  end
end