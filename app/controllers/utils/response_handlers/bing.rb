module Utils
  module ResponseHandlers
    class Bing
      def parse(data)
        data["webPages"]["value"].map{ |i| { name:i["name"], url:i["url"] } }
      end
    end
  end
end