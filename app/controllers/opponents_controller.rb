class OpponentsController < ApplicationController
  def new
    @opponent = Opponent.new
    @matchups = Matchup.all
    @entrants = Entrant.all
  end

  def create
    @opponent = Opponent.new(opponent_params)
    if @opponent.save
      redirect_to opponents_path
    else
      render "new"
    end
  end

  def index
    @opponents = Opponent.all
  end

  private

  def opponent_params
    params.require(:opponent).permit(:matchup_id, :entrant_id)
  end
end
