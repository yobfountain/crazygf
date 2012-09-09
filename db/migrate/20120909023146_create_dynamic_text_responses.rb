class CreateDynamicTextResponses < ActiveRecord::Migration
  def change
    create_table :dynamic_text_responses do |t|
      t.text :text
      t.integer :dynamic_text_id

      t.timestamps
    end
  end
end
