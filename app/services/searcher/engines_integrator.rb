module Services
  class EnginesIntegrator
    def self.fetch_data(engines, text, options)
      engines = engines.map{ |e| Factory.for(e, text) }
      engines.each{ |e| e.fetch_results(options) }
      engines.select{ |e| e.valid? }
        .inject([]){ |a, i| a + i.result }
    end
  end
end