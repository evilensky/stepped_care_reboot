SteppedCareReboot::Application.routes.draw do
  devise_for :participants
  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  scope constraints: { format: 'html' } do
    get "navigator", to: "navigator#show", as: 'navigator'
    resource :activity_tracker, only: :show
    resources :participant_data, only: :create
  end

  root to: 'home#index'
end
