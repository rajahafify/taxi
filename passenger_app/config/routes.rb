PassengerApp::Application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users
      resources :bookings do
        member do
          get :details
        end
      end
    end
  end
end
