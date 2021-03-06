module Investigations
  class VisibilityController < ApplicationController
    def show
      @investigation = Investigation.find_by!(pretty_id: params[:investigation_pretty_id]).decorate
      authorize @investigation, :change_owner_or_status?
      @last_update_visibility_activity = @investigation.activities.where(type: "AuditActivity::Investigation::UpdateVisibility").order(:created_at).first
    end

    def restrict
      change_case_visibility(new_visibility: "restricted", template: :restrict, flash: "restricted")
    end

    def unrestrict
      change_case_visibility(new_visibility: "unrestricted", template: :unrestrict, flash: "unrestricted")
    end

  private

    def change_case_visibility(new_visibility:, template:, flash:)
      @investigation = Investigation.find_by!(pretty_id: params[:investigation_pretty_id])
      authorize @investigation, :change_owner_or_status?

      @change_case_visibility_form = ChangeCaseVisibilityForm.from(@investigation)
      @change_case_visibility_form.assign_attributes(change_case_visibility_form_params.merge(new_visibility: new_visibility))

      # If not a PATCH request we should escape now and just display the form.
      if !@change_case_visibility_form.valid? || !request.patch?
        @investigation = @investigation.decorate
        return render(template)
      end

      ChangeCaseVisibility.call!(@change_case_visibility_form.serializable_hash.merge(user: current_user, investigation: @investigation))

      redirect_to investigation_path(@investigation), flash: { success: "#{@investigation.case_type.upcase_first} was #{flash}" }
    end

    def change_case_visibility_form_params
      return {} unless request.patch?

      params.require(:change_case_visibility_form).permit(:rationale)
    end
  end
end
