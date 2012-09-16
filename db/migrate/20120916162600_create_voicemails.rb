class CreateVoicemails < ActiveRecord::Migration
  def change
    create_table :voicemails do |t|
      t.integer :user_id
      t.string :url
      t.boolean :approved
      t.boolean :featured
      t.integer :duration

      t.timestamps
    end
  end
end
