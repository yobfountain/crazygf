class CreateUserAliases < ActiveRecord::Migration
  def change
    create_table :user_aliases do |t|
      t.string :name

      t.timestamps
    end
  end
end
