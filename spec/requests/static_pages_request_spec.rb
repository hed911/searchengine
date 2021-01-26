require 'rails_helper'

RSpec.describe "Static Pages", type: :request do
  it 'Render a home page' do
    get '/'
    expect(response).to have_http_status(200)
  end
end

