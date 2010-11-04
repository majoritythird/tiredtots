Sleepmonster::Application.routes.draw do
  devise_for :users
  resources :children, :only => [:index, :new, :create, :edit, :update] do
    resources :sleep_blocks, :only => [:index, :create, :edit, :update, :destroy]
  end

  match "/children/:child_id/sleep_blocks/:date", :to => "sleep_blocks#for_date", :as => "child_sleep_blocks_for_date"
  match "/children/:child_id/sleep_blocks/page/:page", :to => "sleep_blocks#paged", :as => "child_sleep_blocks_paged"

  root :to => "welcome#index"
end
