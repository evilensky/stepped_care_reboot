module ContentProviders
  # Provides a checklist of a random set of Activities for a Participant to
  # plan.
  class ImportantActivityChecklist < BitPlayer::ContentProvider
    def render_current(options)
      options.view_context.render(
        template: 'activities/important_activity_checklist',
        locals: {
          past_activities: activities(options.participant),
          create_path: options.view_context.participant_data_path
        }
      )
    end

    def data_attributes
      [activity_type_ids: []]
    end

    def data_class_name
      'UnplannedActivities'
    end

    def show_nav_link?
      false
    end

    private

    def activities(participant)
      participant.activities
        .accomplished
        .random
        .in_the_past
        .first(5)
    end
  end
end
