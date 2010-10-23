Sleepmonster::Application.routes.draw do
  devise_for :users
  resources :children, :only => [:index, :new, :create, :edit, :update] do
    resources :sleep_blocks, :only => [:index, :create, :edit, :update]
  end

  root :to => "welcome#index"
end
