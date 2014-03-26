class Participant::Phq9sController < ApplicationController

  layout "phq9"

  def new
    @phq9 = Phq9.new
    @token = params[:token]
  end

  def create
    @participant = Participant.where(id: ParticipantToken.decrypt_token(params[:token])[0]).first
    @phq9 = @participant.phq9s.build(phq9_params)

    if @phq9.save
      redirect_to root_url, notice: "Assessment saved"
    else
      errors = @phq9.errors.full_messages.join(", ")
      flash.now[:alert] = "Unable to save assessment: #{ errors }"
      render :new
    end
  end

  private

  def phq9_params
    params
      .require(:phq9)
      .permit(:particpant_id, :q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :token)
  end
end
