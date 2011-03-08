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
    respond_with child do |format|
      if child.save
        format.html { redirect_to children_path }
        format.mobile { redirect_to root_path }
      else
        format.any { render :new }
      end
    end
  end

  def update
    respond_with child do |format|
      if child.save
        format.html { redirect_to children_path }
        format.mobile { redirect_to root_path }
      else
        format.any { render :edit }
      end
    end
  end

end
