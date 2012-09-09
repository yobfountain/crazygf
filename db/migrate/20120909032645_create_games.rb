class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.text :description
      t.text :text
      t.integer :score, :default => 0
      t.integer :chances
      t.text :success_response
      t.text :failure_response
      t.text :default_response

      t.timestamps
    end
  end
end
