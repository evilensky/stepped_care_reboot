class ParticipantDataController < ApplicationController
  include Concerns::NavigatorEnabled

  before_filter :authenticate_participant!, :instantiate_navigator

  layout 'tool'

  def create
    @data = current_participant
      .build_data_record(collection_association, data_attributes)

    if @data.save
      flash[:notice] = provider.data_class_name + ' saved'

      respond_to do |format|
        format.html { redirect_to navigator_next_content_url }
        format.js { render status: 201 }
      end
    else
      flash.now[:alert] = @data.errors.full_messages.join(', ')

      respond_to do |format|
        format.html { render template: 'navigator/show_content' }
        format.js { render status: 400 }
      end
    end
  end

  def update
    @data = current_participant
      .fetch_data_record(collection_association, data_attributes[:id])

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

  private

  def provider
    @provider ||= @navigator.current_content_provider
  end

  def singular_association
    @singular_association ||= provider.data_class_name.underscore
  end

  def collection_association
    singular_association.pluralize
  end

  def data_attributes
    @data_attributes ||= params
      .fetch(singular_association, {})
      .permit(provider.data_attributes)
  end
end
