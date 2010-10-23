class AddParameterizedNameToChildren < ActiveRecord::Migration
  def self.up
    add_column :children, :parameterized_name, :string
  end

  def self.down
    remove_column :children, :parameterized_name
  end
end
