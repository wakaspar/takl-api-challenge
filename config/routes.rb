Rails.application.routes.draw do
  # creates routes for Route and Address tables
  resources :routes do
    resources :addresses
  end

end
