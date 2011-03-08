Sleepmonster::Application.routes.draw do
  devise_for :users
  resources :children, only: [:index, :new, :create, :edit, :update] do
    resources :sleep_blocks, only: [:index, :new, :create, :edit, :update, :destroy] do
      collection do
        get "/for/:date", to: "sleep_blocks#for_date", as: "for_date"
        get "/page/:page", to: "sleep_blocks#paged", as: "paged"
      end
    end
  end

  get "/mobile", to: "application#mobile"
  get "/fullsite", to: "application#fullsite"

  root to: "welcome#index"
end
