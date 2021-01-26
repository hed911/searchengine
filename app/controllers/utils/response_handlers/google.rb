module Utils
  module ResponseHandlers
    class Google
      def parse(data)
        data["items"].map{ |i| { name:i["title"], url:i["link"] } }
      end
    end
  end
end