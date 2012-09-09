class CreateDynamicConversations < ActiveRecord::Migration
  def change
    create_table :dynamic_conversations do |t|
      t.integer :user_id
      t.integer :dynamic_text_response_id

      t.timestamps
    end
  end
end
