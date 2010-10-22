class ChildrenController < ApplicationController

  expose(:child) { params[:child] ? current_user.children.create(params[:child]) : current_user.children.build }
  expose(:children) { current_user.children }

  def create
    child.save
    respond_with child, :location => children_path
  end

end
