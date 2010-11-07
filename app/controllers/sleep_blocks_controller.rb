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
  expose(:per_page) { 20 }
  expose(:sleep_blocks) { child.sleep_blocks.covering(Date.parse(params[:date])) }
  expose(:tracked_days) { child.tracked_days.paged(params[:page] || 0, per_page).descending }
  expose(:more_tracked_days) { child.tracked_days.count > (params[:page].to_i + 1) * per_page }
  expose(:times) do
    the_time = Time.parse("2010-01-01 12am")
    times = []
    144.times do
      times << the_time
      the_time += 10.minutes
    end
    times
  end

  def paged
    html = render_to_string(:partial => 'tracked_days.html.haml', :locals => {:tracked_days => tracked_days, :times => times})
    link = if more_tracked_days
             render_to_string(:partial => 'view_more.html.haml', :locals => {:child => child})
           else
             ""
           end
    render(:json => {:html => html, :link => link})
  end

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
