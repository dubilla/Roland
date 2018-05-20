class MatchupsController < ApplicationController
  def edit
    @matchup = Matchup.find(params[:id])
  end

  def update
    matchup = Matchup.find(params[:id])
    matchup.update_attributes(update_params)
    if matchup.save
      redirect_to tournament_path(matchup.tournament)
    else
      render edit
    end
  end

  private

  def update_params
    params.require(:matchup).permit(opponents_attributes: [:id, :winner])
  end
end
