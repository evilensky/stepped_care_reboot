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
  # config.audit_with :paper_trail, "User", "PaperTrail::Version" # PaperTrail >= 3.0.0

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

  config.model "Activity" do
    navigation_label "Participant data"

    list do
      sort_by :participant_id, :start_time

      field :participant
      field :start_time
      field :activity_type
      field :actual_accomplishment_intensity
      field :actual_pleasure_intensity
    end
  end

  config.model "AwakePeriod" do
    navigation_label "Participant data"

    list do
      field :participant
      field :start_time
      field :end_time
    end
  end

  config.model "Thought" do
    navigation_label "Participant data"

    list do
      field :participant
      field :content
      field :effect
    end
  end

  config.model "ActivityType" do
    list do
      sort_by :participant, :title

      field :participant
      field :title
    end
  end

  config.model "ContentProvider" do
    list do
      field :context
      field :content_module
      field :position
    end
  end

  config.model "ContentProviders::SlideshowProvider" do
    edit do
      field :content_module
      field :position
      field :source_content
    end
  end

  config.model "BitPlayer::ContentModule" do
    list do
      sort_by :tool, :position

      field :tool
      field :position
      field :title
      field :content_providers do
        pretty_value do
          value.count
        end
      end
    end
  end

  config.model "DeliveredMessage" do
    object_label_method do
      :recipient_email
    end
    list do
      field :recipient
      field :is_read
      field :message
      field :created_at
    end
  end

  def recipient_email
    "#{recipient.email}"
  end

  config.model "Group" do
    list do
      field :title
      field :creator
      field :created_at
    end

    edit do
      field :title
      field :creator
      field :active_participants
    end
  end

  config.model "Membership" do
    list do
      field :group
      field :participant
      field :start_date
      field :end_date
    end

    edit do
      field :group
      field :participant
      field :start_date
      field :end_date
    end
  end

   config.model "Message" do
    object_label_method do
      :sender_email
    end

    list do
      field :sender
      field :subject
      field :sent_at
      field :delivered_messages
    end
  end
  
  def sender_email
    "#{sender.email}"
  end

  config.model "Participant" do
    object_label_method do
      :email
    end

    list do
      field :email
      field :groups
    end

    edit do
      field :email
      field :password
      field :password_confirmation
      field :groups
      field :participant_tokens
      field :coach_assignment
    end
  end

  config.model "PhqAssessment" do

    list do
      field :participant
      field :release_date
      field :created_at
      field :q9
      field :score
    end
  end

  config.model "Slide" do
    list do
      sort_by :slideshow_id, :position

      field :slideshow
      field :position
      field :title
      field :body
    end
  end

  config.model "Slideshow" do
    list do
      field :title
      field :slides
    end
  end

  config.model "TaskStatus" do
    list do
      field :task
      field :participant
      field :completed_at
    end
  end

  config.model "User" do
    object_label_method do
      :email
    end

    list do
      field :email
      field :last_sign_in_at
    end

    edit do
      field :email
      field :password
      field :password_confirmation
      field :coach_assignments
    end
  end
end
