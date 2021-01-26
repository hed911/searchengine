module Utils
  class ResponseParser
    def self.parse(data, provider)
      data.map{ |i| i.merge({ provider:provider }) }
    end
  end
end