Rails.application.routes.draw do
  if Rails.env.development?
    mount Rswag::Ui::Engine => "/api-docs"
    root to: redirect("/api-docs")
  end

  resources :partners, only: %i[show] do
    collection do
      post :search
    end
  end
end
