module Coach
  # Provides helpers for coach message composition.
  module MessagesHelper
    # Returns grouped options for selecting a section of the site.
    def grouped_options_for_site_link_select
      AppSection::SECTIONS.map do |context, title|
        context_options = modules_for_context(context).map do |m|
          [m.title, navigator_location_path(module_id: m.id)]
        end

        [title, context_options]
      end
    end

    private

    def modules_for_context(c)
      BitPlayer::ContentModule
        .joins(:tool)
        .where("bit_player_tools.title = ?", c)
        .where.not("bit_player_content_modules.title = ''")
    end
  end
end
