SteppedCareReboot::Application.routes.draw do
  devise_for :participants
  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  scope constraints: { format: 'html' } do
    get 'navigator/next_content', to: 'navigator#show_next_content', as: 'navigator_next_content'
    get 'navigator/contexts/:context_name', to: 'navigator#show_context', as: 'navigator_context'
    get 'navigator/modules/:module_id(/providers/:provider_id/:content_position)', to: 'navigator#show_location', as: 'navigator_location'
    resource :participant_data, only: [:create, :update]
    resource :flow, only: :show
  end

  root to: 'navigator#show_context'
end
