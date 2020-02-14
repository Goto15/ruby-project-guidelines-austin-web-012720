class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.integer :day_id
      t.integer :user_id
      t.string :name
      t.string :weather
    end
  end
end
