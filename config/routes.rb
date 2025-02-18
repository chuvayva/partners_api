Rails.application.routes.draw do
  resources :partners, only: %i[show]
end
