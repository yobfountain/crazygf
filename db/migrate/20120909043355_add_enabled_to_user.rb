class AddEnabledToUser < ActiveRecord::Migration
  def change
    add_column :users, :enabled, :boolean, :default => 1
  end
end
