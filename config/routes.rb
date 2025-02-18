Rails.application.routes.draw do
  resources :partners, only: %i[show] do
    collection do
      post :search
    end
  end
end
