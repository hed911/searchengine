class MainController < ApplicationController
  before_action :validate_params, only:[:search]

  def search
    engines_strings = search_params[:engine].strip.split(',')
    engines = engines_strings.map{ |e| Utils::Factory.for(e, search_params[:text]) }

    options = {}
    options[:offset] = search_params[:offset] if search_params.has_key?(:offset)
    options[:count] = search_params[:count] if search_params.has_key?(:count)

    engines.each{ |e| e.fetch_results(options) }

    results = engines.select{ |e| e.valid? }
      .inject([]){ |a, i| a + i.result }
      
    render json:{ items:results }.to_json
  end

  private

  def search_params
    params.permit(:engine, :text, :offset, :count)
  end

  def validate_params
    validator = ParamsValidator::Search.new(search_params.to_h)
    if !validator.valid?
      render json: { error: validator.errors }, status: 400 and return
    end
  end
end