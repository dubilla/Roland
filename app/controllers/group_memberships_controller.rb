class GroupMembershipsController < ApplicationController
  def new
    @group_membership = GroupMembership.new(group_id: params[:group_id])
    @group = Group.find(params[:group_id])
  end

  def create
    binding.pry
    @group_membership = GroupMembership.new(membership_params)
    if @group_membership.save
      redirect_to @group_membership.group
    else
      render "new"
    end
  end

  private

  def membership_params
    params.permit(:group_id).merge(group_id: params[:group_id], user_id: current_user.id)
  end
end
