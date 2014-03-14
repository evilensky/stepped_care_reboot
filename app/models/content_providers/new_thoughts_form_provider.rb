module ContentProviders
  class NewThoughtsFormProvider < BitPlayer::ContentProvider
    def render_current(options)
      options.view_context.render(
        template: 'thoughts/new_bulk',
        locals: {
          thoughts: (1..3).map { options.participant.thoughts.build },
          create_path: options.view_context.participant_data_path
        }
      )
    end

    def data_class_name
      'Thought'
    end

    def data_attributes
      [:content, :effect]
    end

    def show_nav_link?
      false
    end
  end
end
