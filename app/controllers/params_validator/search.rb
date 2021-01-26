module ParamsValidator
  class Search
    include ActiveModel::Validations
    attr_accessor :engine, :text, :offset, :count
    validates_presence_of :engine, :text
    validates_length_of :engine, :minimum => 2, :maximum => 20
    validates_length_of :text, :minimum => 3, :maximum => 2048

    validates_each :engine do |record, field, value|
      unless value.nil?
        SUPPORTED_ENGINES = ['google', 'bing']
        values = value.strip.split(',')
        values.select{ |v| !SUPPORTED_ENGINES.include?(v) }
          .each{ |v| record.errors.add(field, "Engine (#{v}) not supported") }
      end
    end

    validates_each :offset do |record, field, value|
      start_value = 0
      end_value = 9999999
      if !value.nil?
        if !(value =~ /\A[-+]?[0-9]+\z/)
          record.errors.add(field, 'Must be an number')
        else
          unless value.to_i.between?(start_value, end_value)
            record.errors.add(field, "Must be between (#{start_value} - #{end_value})")
          end
        end
      end
    end

    validates_each :count do |record, field, value|
      start_value = 1
      end_value = MAX_NUMBER_OF_PAGES
      if !value.nil?
        if !(value =~ /\A[-+]?[0-9]+\z/)
          record.errors.add(field, 'Must be an number')
        else
          unless value.to_i.between?(start_value, end_value)
            record.errors.add(field, "Must be between (#{start_value} - #{end_value})")
          end
        end
      end
    end

    def initialize(params={})
      @engine  = params[:engine]
      @text = params[:text]
      @offset = params[:offset]
      @count = params[:count]
      ActionController::Parameters.new(params).permit(:engine, :text)
    end

  end

end