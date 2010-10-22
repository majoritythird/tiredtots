Sleepmonster::Application.routes.draw do
  resources :children, :only => [:index, :new, :create]

  root :to => "welcome#index"
end
