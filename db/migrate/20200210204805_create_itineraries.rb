class CreateItineraries < ActiveRecord::Migration[5.0]
  def change
    create_table :itineraries do |t|
      t.integer :user_id
      t.string :date
    end
  end
end
