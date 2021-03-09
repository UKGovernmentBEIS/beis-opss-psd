module Investigations
  class NotifyingCountryController < ApplicationController
    def edit
      @investigation = Investigation.find_by!(pretty_id: params.require(:investigation_pretty_id)).decorate
      authorize @investigation, :update?
      @notifying_country_form = NotifyingCountryForm.from(@investigation)
    end

    def update
      @investigation = Investigation.find_by!(pretty_id: params[:investigation_pretty_id])
      authorize @investigation, :update?

      @notifying_country_form = NotifyingCountryForm.new(country: params["investigation"]["country"])

      if @notifying_country_form.valid?
        result = UpdateNotifyingCountry.call!(
          @notifying_country_form.serializable_hash.merge({
            investigation: @investigation,
            user: current_user
          })
        )

        # @investigation.update(notifying_country: @notifying_country_form.country)

        redirect_to investigation_path(@investigation), flash: { success: "#{@investigation.pretty_id} was successfully updated." }
      else
        @investigation = @investigation.decorate
        render :edit
      end
    end
  end
end
