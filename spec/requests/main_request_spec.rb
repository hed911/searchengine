require 'rails_helper'

RSpec.describe "Search API", type: :request do

  let(:google_engine) { build(:google_engine) }
  let(:bing_engine) { build(:bing_engine) }
  let(:yahoo_engine) { build(:yahoo_engine) }

  let(:short_text) { build(:short_text) }
  let(:long_text) { build(:long_text) }

  it 'Shows errors when required params (engine, text) are not present' do
    get '/search'
    expect(response).to have_http_status(400)
    expect(JSON.parse(response.body)["error"]["engine"]).to include("can't be blank")
    expect(JSON.parse(response.body)["error"]["text"]).to include("can't be blank")
  end

  it 'Shows errors when required params (engine) is not bing or google' do
    get "/search?engine=#{yahoo_engine.name}"
    expect(response).to have_http_status(400)
    expect(JSON.parse(response.body)["error"]["engine"]).to include("Engine (yahoo) not supported")
  end

  it 'Shows errors when required params (text) has less than 3 characters' do
    get "/search?text=#{short_text.value}"
    expect(response).to have_http_status(400)
    expect(JSON.parse(response.body)["error"]["text"]).to include("is too short (minimum is 3 characters)")
  end

  it 'Fetch results from google search' do
    get "/search?engine=#{google_engine.name}&text=#{long_text.value}"
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)["items"].map{ |i| i["provider"] }).to include(google_engine.name)
  end

  it 'Fetch results from bing search' do
    get "/search?engine=#{bing_engine.name}&text=#{long_text.value}"
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)["items"].map{ |i| i["provider"] }).to include(bing_engine.name)
  end

  it 'Fetch results from bing and google search' do
    get "/search?engine=#{bing_engine.name},#{google_engine.name}&text=#{long_text.value}"
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)["items"].map{ |i| i["provider"] }).to include(bing_engine.name)
    expect(JSON.parse(response.body)["items"].map{ |i| i["provider"] }).to include(google_engine.name)
  end
end

