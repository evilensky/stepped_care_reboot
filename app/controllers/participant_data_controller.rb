class ParticipantDataController < ApplicationController
  def create
    navigator = Navigator.new(session)
    provider = navigator.current_content_provider
    parameter = provider.data_class_name.underscore
    data_attributes = params.require(parameter).permit(provider.data_attributes)
    association = parameter.pluralize

    @data = current_participant.send(association).build(data_attributes)

    if @data.save
      redirect_to next_provider_url
    else
      render text: @data.errors.full_messages
    end
  end
end
