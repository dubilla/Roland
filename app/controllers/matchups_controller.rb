class MatchupsController < ApplicationController
  def edit
    @matchup = Matchup.find(params[:id])
  end
end
