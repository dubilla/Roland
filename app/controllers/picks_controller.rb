class PicksController < ApplicationController
  def edit
    @pick = Pick.find(params[:id])
    @opponents = Slot.includes(matchup: :opponents).find(@pick.slot.subtree_ids).map(&:matchup).compact.flat_map(&:opponents)
  end

  def update
    @pick = Pick.find(params[:id])
    if save_picks
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

  def save_picks
    ActiveRecord::Base.transaction do
      picks.each do |p|
        p.update_attributes(pick_params)
      end
    end
  end

  def picks
    @pick.entry.picks.joins(:slot).where(slot: slots)
  end

  def slots
    @slots ||= root_slot.path.reverse[0..@pick.slot.depth]
  end

  def root_slot
    Slot.joins(:tournament).joins(matchup: :opponents).uniq.where("opponents.id = ?", pick_params[:opponent_id]).first
  end
end
