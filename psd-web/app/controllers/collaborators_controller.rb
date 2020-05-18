class CollaboratorsController < ApplicationController
  before_action do
    find_investigation_from_params
  end

  def index
    binding.pry if $use_pry
    @teams = @investigation.editors.order(:name)
  end

  def new
    authorize @investigation, :manage_collaborators?

    @edition = @investigation.edition.new

    @teams = teams_without_access
  end

  def create
    authorize @investigation, :manage_collaborators?

    result = AddTeamToAnInvestigation.call(
      params.require(:edition).permit(:collaborator_id, :include_message, :message).merge({
        investigation: @investigation,
        current_user: current_user
      })
    )

    if result.success?
      redirect_to investigation_collaborators_path(@investigation)
    else
      @teams = teams_without_access
      @edition = result.edition
      render "collaborators/new"
    end
  end

  def edit
    authorize @investigation, :manage_collaborators?

    @team = Team.find(params[:id])
    @editor = @investigation.editors.find_by! collaborator_id: @team.id
    @edit_form = EditInvestigationCollaboratorForm.new(permission_level: EditInvestigationCollaboratorForm::PERMISSION_LEVEL_EDIT)
  end

  def update
    authorize @investigation, :manage_collaborators?

    @team = Team.find(params[:id])
    @edit_form = EditInvestigationCollaboratorForm.new(edit_params
      .merge(investigation: @investigation, team: @team, user: current_user))
    if @edit_form.save!
      flash[:success] = "#{@team.name} had been removed from the case"
      redirect_to investigation_collaborators_path(@investigation)
    else
      render "edit"
    end
  end

private

  # rubocop:disable Naming/MemoizedInstanceVariableName
  def find_investigation_from_params
    @investigation ||= Investigation.find_by!(pretty_id: params[:investigation_pretty_id])
  end
  # rubocop:enable Naming/MemoizedInstanceVariableName

  def teams_without_access
    Team.where.not(id: team_ids_with_access).order(:name)
  end

  def team_ids_with_access
    @investigation.editors.pluck(:collaborator_id) + [@investigation.owner_team.try(:id)]
  end

  def edit_params
    params.require(:edit_investigation_collaborator_form).permit(:permission_level, :include_message, :message)
  end
end
