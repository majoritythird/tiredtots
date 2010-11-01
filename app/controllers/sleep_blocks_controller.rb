class SleepBlocksController < ApplicationController
  before_filter :authenticate_user!

  expose(:child) { current_user.children.find_by_parameterized_name params[:child_id] }
  expose(:sleep_block) do
    if child.sleep_blocks.unfinished.any? && params[:id].nil?
      child.sleep_blocks.unfinished.first
    elsif params[:id]
      child.sleep_blocks.find(params[:id]).tap do |sleep_block|
        sleep_block.update_attributes(params[:sleep_block])
      end
    elsif params[:sleep_block]
      child.sleep_blocks.build(params[:sleep_block])
    else
      child.sleep_blocks.build
    end
  end
  expose(:tracked_days) { child.tracked_days }

  def create
    sleep_block.save
    respond_with sleep_block, :location => child_sleep_blocks_path(child)
  end

  alias update create

  def destroy
    sleep_block.destroy
    respond_with sleep_block, :location => child_sleep_blocks_path(child)
  end

end
