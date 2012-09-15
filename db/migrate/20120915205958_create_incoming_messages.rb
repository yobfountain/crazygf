class CreateIncomingMessages < ActiveRecord::Migration
  def change
    create_table :incoming_messages do |t|
      t.integer :user_id
      t.text :content
      t.integer :response_id
      t.string :response_type
      t.boolean :reviewed

      t.timestamps
    end
  end
end
