module ContentProviders
  # Provides multiple forms for a Participant to enter past Activities.
  class PastActivityForm < BitPlayer::ContentProvider
    def render_current(options)
      options.view_context.render(
        template: 'activities/past_activity_form',
        locals: {
          timestamps: timestamps,
          activity: Activity.new,
          create_path: options.view_context.participant_data_path
        }
      )
    end

    def data_attributes
      [
        :start_time,
        :end_time,
        :activity_type_title,
        :actual_pleasure_intensity,
        :actual_accomplishment_intensity
      ]
    end

    def data_class_name
      'Activity'
    end

    def show_nav_link?
      false
    end

    private

    def timestamps
      period = AwakePeriod.last
      start_time, end_time = period.start_time, period.end_time
      times = []
      (start_time.to_i .. (end_time.to_i - 1.hour)).step(1.hour) do |timestamp|
        times << timestamp
      end

      times
    end
  end
end
