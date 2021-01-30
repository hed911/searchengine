class MainController < ApplicationController
  before_action :validate_params

  def search
    engines_strings = search_params[:engine].strip.split(',')
    options = {}
    options[:offset] = search_params[:offset] if search_params.has_key?(:offset)
    options[:count] = search_params[:count] if search_params.has_key?(:count)
    results = Services::EnginesIntegrator.fetch_data(
      engines_strings,
      search_params[:text],
      options
    )
    render json:{ items:results }.to_json
  end

  private

  def search_params
    params.permit(:engine, :text, :offset, :count)
  end

  def validate_params
    validator = Validators::Search.new(search_params.to_h)
    if !validator.valid?
      render json: { error: validator.errors }, status: 400 and return
    end
  end
end