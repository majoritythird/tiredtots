class ChildrenController < ApplicationController
  before_filter :authenticate_user!

  expose(:child) { params[:child] ? current_user.children.create(params[:child]) : current_user.children.build }
  expose(:children) { current_user.children }

  def create
    child.save
    respond_with child, :location => children_path
  end

end
