class ChildrenController < ApplicationController
  before_filter :authenticate_user!

  expose(:child) do
    if params[:id]
      current_user.children.find_by_parameterized_name(params[:id]).tap do |child|
        child.update_attributes(params[:child])
      end
    elsif params[:child]
      current_user.children.create(params[:child])
    else
      current_user.children.build
    end
  end
  expose(:children) { current_user.reload.children }

  def create
    the_response = child.save ? redirect_to(children_path) : render(:new)
    respond_with child do |format|
      format.any { the_response }
    end
  end

  def update
    the_response = child.save ? redirect_to(children_path) : render(:edit)
    respond_with child do |format|
      format.any { the_response }
    end
  end

end
