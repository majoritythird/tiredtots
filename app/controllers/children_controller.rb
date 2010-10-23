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
  expose(:children) { current_user.children }

  def create
    child.save
    respond_with child, :location => children_path
  end

  alias update create

end
