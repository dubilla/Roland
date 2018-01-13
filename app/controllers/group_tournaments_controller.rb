class GroupTournamentsController < ApplicationController
  def create
    @group_tournament = GroupTournament.new(group_tournament_params)
    @group_tournament.save
    redirect_to @group_tournament.group
  end

  def show
    @group_tournament = GroupTournament.includes(:entries).find(params[:id])
  end

  private

  def group_tournament_params
    params.permit(:group_id, :tournament_id)
  end
end
