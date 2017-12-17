class GroupTournamentsController < ApplicationController
  def show
    @group_tournament = GroupTournament.find(params[:id])
  end
end
