class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :itinerary_id
      t.string :name
      # Stretch goal of category
    end
  end
end
