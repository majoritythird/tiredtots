Sleepmonster::Application.routes.draw do
  devise_for :users
  resources :children, :only => [:index, :new, :create] do
    resources :sleep_blocks, :only => [:index, :new, :create, :edit, :update]
  end

  root :to => "welcome#index"
end
