SteppedCareReboot::Application.routes.draw do
  devise_for :participants
  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  scope constraints: { format: 'html' } do
    resource :next_provider, only: :show
    resource :activity_tracker, only: :show
    resource :generic_tool
    resources :participant_data, only: :create
  end

  root to: 'home#index'
end
