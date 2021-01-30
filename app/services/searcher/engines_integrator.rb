module Services
  class EnginesIntegrator
    def self.fetch_data(engines_strings, text, options)
      engines = engines_strings.map{ |e| Factory.for(e, text) }
      engines.each{ |e| e.fetch_results(options) }
      engines.select{ |e| e.valid? }
        .inject([]){ |a, i| a + i.result }
    end
  end
end