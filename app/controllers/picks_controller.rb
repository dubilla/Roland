class PicksController < ApplicationController
  def edit
    @pick = Pick.find(params[:id])
    @opponents = @pick.slot.tournament.opponents
  end

  def update
    @pick = Pick.find(params[:id])
    if @pick.update_attributes(pick_params)
      flash[:success] = "Pick made"
      redirect_to @pick.entry
    else
      render "edit"
    end
  end

  private

  def pick_params
    params.require(:pick).permit(:opponent_id)
  end
end
