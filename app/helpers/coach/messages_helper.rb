module Coach::MessagesHelper
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
    BitPlayer::ContentModule.where(context: c).where.not(title: '')
  end
end
