Rails.application.routes.draw do
  root "static_pages#home"
  get 'search', to: 'main#search', as: :search
  get "home" => "static_pages#home", as: :home
end
