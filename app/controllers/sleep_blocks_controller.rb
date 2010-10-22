class SleepBlocksController < ApplicationController

  expose(:child) { current_user.children.find params[:child_id] }
  expose(:sleep_block) { params[:sleep_block] ? child.sleep_blocks.create(params[:sleep_block]) : child.sleep_blocks.build }
  expose(:sleep_blocks) { child.sleep_blocks }

  def create
    sleep_block.save
    respond_with sleep_block, :location => child_sleep_blocks_path(child)
  end

end
