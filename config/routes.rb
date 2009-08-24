ActionController::Routing::Routes.draw do |map|
  # map.resources :questions
  map.root :controller => :home
  map.connect ':id', :controller => :questions, :action => :show
  
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
