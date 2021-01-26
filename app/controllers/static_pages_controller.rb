class StaticPagesController < ApplicationController
  include ActionView::Layouts
  include ActionController::Rendering

  def home
    render 'static_pages/home'
  end
  
end