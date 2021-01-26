require 'rails_helper'

RSpec.describe "Search API", type: :request do
  it 'Shows errors when required params (engine, text) are not present' do
    get '/search'
    expect(response).to have_http_status(400)
    expect(JSON.parse(response.body)["error"]["engine"]).to include("can't be blank")
    expect(JSON.parse(response.body)["error"]["text"]).to include("can't be blank")
  end

  it 'Shows errors when required params (engine) is not bing or google' do
    get '/search?engine=yahoo'
    expect(response).to have_http_status(400)
    expect(JSON.parse(response.body)["error"]["engine"]).to include("Engine (yahoo) not supported")
  end

  it 'Shows errors when required params (text) has less than 3 characters' do
    get '/search?text=ab'
    expect(response).to have_http_status(400)
    expect(JSON.parse(response.body)["error"]["text"]).to include("is too short (minimum is 3 characters)")
  end

  it 'Fetch results from google search' do
    get '/search?engine=google&text=iphone'
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)["items"].map{ |i| i["provider"] }).to include("google")
  end

  it 'Fetch results from bing search' do
    get '/search?engine=bing&text=iphone'
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)["items"].map{ |i| i["provider"] }).to include("bing")
  end

  it 'Fetch results from bing and google search' do
    get '/search?engine=google,bing&text=iphone'
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)["items"].map{ |i| i["provider"] }).to include("bing")
    expect(JSON.parse(response.body)["items"].map{ |i| i["provider"] }).to include("google")
  end
end

