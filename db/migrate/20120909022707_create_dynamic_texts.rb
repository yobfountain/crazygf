class CreateDynamicTexts < ActiveRecord::Migration
  def change
    create_table :dynamic_texts do |t|
      t.string :name
      t.string :description
      t.text :keywords
      t.integer :score, :default => 0
      t.integer :category_id
      t.string  :image_url

      t.timestamps
    end
  end
end
