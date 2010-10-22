class SleepBlocksController < ApplicationController

  expose(:child) { current_user.children.find params[:child_id] }
  expose(:sleep_block) do
    if child.sleep_blocks.open.any? && params[:id].nil?
      child.sleep_blocks.open.first
    elsif params[:id]
      child.sleep_blocks.find(params[:id]).tap do |sleep_block|
        sleep_block.update_attributes(params[:sleep_block])
      end
    elsif params[:sleep_block]
      child.sleep_blocks.create(params[:sleep_block])
    else
      child.sleep_blocks.build
    end
  end
  expose(:sleep_blocks) { child.sleep_blocks }

  def create
    sleep_block.save
    respond_with sleep_block, :location => child_sleep_blocks_path(child)
  end

  alias update create

end
