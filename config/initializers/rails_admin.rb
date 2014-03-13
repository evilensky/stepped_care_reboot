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

  config.model 'Activity' do
    navigation_label 'Participant data'

    list do
      sort_by :participant_id, :start_time

      field :participant
      field :start_time
      field :activity_type
      field :actual_accomplishment_intensity
      field :actual_pleasure_intensity
    end
  end

  config.model 'AwakePeriod' do
    navigation_label 'Participant data'

    list do
      field :participant
      field :start_time
      field :end_time
    end
  end

  config.model 'Thought' do
    navigation_label 'Participant data'

    list do
      field :participant
      field :content
      field :effect
    end
  end

  config.model 'ActivityType' do
    list do
      sort_by :participant, :title

      field :participant
      field :title
    end
  end

  config.model 'ContentProvider' do
    list do
      field :context
      field :content_module
      field :position
    end
  end

  config.model 'ContentProviders::SlideshowProvider' do
    edit do
      field :content_module
      field :position
      field :source_content
    end
  end

  config.model 'ContentModule' do
    list do
      sort_by :context, :position

      field :context
      field :position
      field :title
      field :providers
    end
  end

  config.model 'Participant' do
    list do
      field :email
      field :groups
    end
  end

  config.model 'Slide' do
    list do
      sort_by :slideshow_id, :position

      field :slideshow
      field :position
      field :title
      field :body
    end
  end

  config.model 'Slideshow' do
    list do
      field :title
      field :slides
    end
  end
end
