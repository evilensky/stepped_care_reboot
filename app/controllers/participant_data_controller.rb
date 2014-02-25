class ParticipantDataController < ApplicationController
  before_filter :authenticate_participant!

  def create
    navigator = Navigator.new(session)
    provider = navigator.current_content_provider
    parameter = provider.data_class_name.underscore
    data_attributes = params.require(parameter).permit(provider.data_attributes)
    association = parameter.pluralize

    @data = current_participant.build_data_record(association, data_attributes)

    if @data.save
      redirect_to navigator_next_content_url
    else
      render text: @data.errors.full_messages
    end
  end
end
