class SleepBlocksController < ApplicationController
  before_filter :authenticate_user!

  expose(:child) { current_user.children.find_by_parameterized_name params[:child_id] }
  expose(:more_tracked_days) { child.tracked_days.count > (params[:page].to_i + 1) * per_page }
  expose(:per_page) { 20 }
  expose(:recent_sleep_blocks) { child.sleep_blocks.limit(10).order('start_time desc') }
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
  expose(:sleep_blocks) { child.sleep_blocks.covering(Date.parse(params[:date])) }
  expose(:ten_minute_times) do
    the_time = Time.parse("2010-01-01 12am")
    times = []
    144.times do
      times << the_time
      the_time += 10.minutes
    end
    times
  end
  expose(:tracked_days) { child.tracked_days.paged(params[:page] || 0, per_page).descending }

  def create
    the_response = sleep_block.save ? redirect_to(child_sleep_blocks_path(child)) : render(:new)
    respond_with child do |format|
      format.any { the_response }
    end
  end

  def destroy
    sleep_block.destroy
    respond_with sleep_block do |format|
      format.any { redirect_to child_sleep_blocks_path(child) }
    end
  end

  def paged
    html = render_to_string(:partial => 'tracked_days.html.haml', :locals => {:tracked_days => tracked_days, :ten_minute_times => ten_minute_times})
    link = if more_tracked_days
             render_to_string(:partial => 'view_more.html.haml', :locals => {:child => child})
           else
             ""
           end
    render(:json => {:html => html, :link => link})
  end

  def update
    the_response = sleep_block.save ? redirect_to(child_sleep_blocks_path(child)) : render(:edit)
    respond_with child do |format|
      format.any { the_response }
    end
  end

end
