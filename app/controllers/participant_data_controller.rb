class ParticipantDataController < ApplicationController
  include Concerns::NavigatorEnabled

  before_filter :authenticate_participant!, :instantiate_navigator

  layout 'tool'

  def create
    provider = @navigator.current_content_provider
    parameter = provider.data_class_name.underscore
    data_attributes = params.fetch(parameter, {}).permit(provider.data_attributes)
    association = parameter.pluralize

    @data = current_participant.build_data_record(association, data_attributes)

    if @data.save
      flash[:notice] = provider.data_class_name + ' saved'

      respond_to do |format|
        format.html { redirect_to navigator_next_content_url }
        format.js { render status: 201 }
        format.json  { render :json => { :status => "success"} }
      end
    else
      flash.now[:alert] = @data.errors.full_messages.join(', ')

      respond_to do |format|
        format.html { render template: 'navigator/show_content'}
        format.js { render status: 400 }
        format.json  { render :json => { :status => "error" } }
      end
    end
  end

  def update
    provider = @navigator.current_content_provider
    parameter = provider.data_class_name.underscore
    data_attributes = params.fetch(parameter, {}).permit(provider.data_attributes)
    association = parameter.pluralize

    @data = current_participant.fetch_data_record(association, data_attributes[:id])

    if @data.update(data_attributes.reject { |a| a == 'id' })
      flash[:notice] = provider.data_class_name + ' saved'

      respond_to do |format|
        format.html { redirect_to navigator_next_content_url }
        format.js {}
      end
    else
      flash.now[:alert] = @data.errors.full_messages.join(', ')

      respond_to do |format|
        format.html { render template: 'navigator/show_content' }
        format.js { render status: 400 }
      end
    end
  end
end
