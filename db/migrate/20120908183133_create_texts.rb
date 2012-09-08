class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :text
      t.integer  :category_id
      t.integer  :score
      t.string   :image_url
      t.string   :picture_file_name
      t.string   :picture_content_type
      t.integer  :picture_file_size
      t.datetime :picture_updated_at

      t.timestamps
    end
  end
end
