RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'ContentProviders::SlideshowProvider' do
    edit do
      field :content_module
      field :position
      field :source_content
    end
  end

  config.model 'Activity' do
    navigation_label 'Participant data'
  end

  config.model 'AwakePeriod' do
    navigation_label 'Participant data'
  end

  config.model 'ContentProvider' do
    list do
      field :context
      field :content_module
      field :position
    end
  end
end
