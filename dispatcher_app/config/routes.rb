DispatcherApp::Application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :drivers do
        member do
          get :details
        end
      end
    end
  end
end
