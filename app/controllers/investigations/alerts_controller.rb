class Investigations::AlertsController < ApplicationController
  include Pundit
  include ActionView::Helpers::NumberHelper

  def about
    @investigation = Investigation.find_by!(pretty_id: params[:investigation_pretty_id])
    authorize @investigation, :send_email_alert?
    @investigation = @investigation.decorate
  end

  def new
    set_and_authorize_investigation

    @alert_form = AlertForm.new(alert_request_params.merge(investigation_url: investigation_url(@investigation)))
    @investigation = @investigation.decorate
  end

  def preview
    set_and_authorize_investigation

    @alert_form = AlertForm.new(alert_request_params.merge(investigation_url: investigation_url(@investigation)))
    @investigation = @investigation.decorate

    return render :new unless @alert_form.valid?

    set_user_count
    get_preview
  end

  def create
    set_and_authorize_investigation

    @alert_form = AlertForm.new(alert_request_params)

    if @alert_form.valid?
      AddAlert.call!(
        @alert_form.attributes.merge({
          investigation: @investigation,
          user: current_user
        })
      )

      @investigation = @investigation.decorate
      redirect_to investigation_path(@investigation), flash: { success: "Email alert sent to users" }
    else
      @investigation = @investigation.decorate
      render :new
    end
  end

private

  def set_and_authorize_investigation
    @investigation = Investigation.not_private.find_by!(pretty_id: params[:investigation_pretty_id])
    authorize @investigation, :send_email_alert?
  end

  def set_alert
    @alert = Alert.new alert_params.merge(
      investigation_id: @investigation.id,
      source: UserSource.new(user: current_user),
      investigation_url: investigation_url(@investigation)
    )
  end

  def alert_request_params
    return {} unless params.key? :alert_form

    params.require(:alert_form).permit(:summary, :description)
  end

  def set_user_count
    @user_count = number_with_delimiter(User.active.count, delimiter: ",")
  end

  def get_preview
    @preview = NotificationsClient.instance.generate_template_preview(
      NotifyMailer::TEMPLATES[:alert],
      personalisation: {
        email_text: @alert_form.description,
        subject_text: @alert_form.summary
      }
    )
  end
end
