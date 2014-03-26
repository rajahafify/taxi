PassengerApp::Application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users
      resources :bookings
    end
  end
end
