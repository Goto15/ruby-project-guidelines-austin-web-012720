class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :location
      t.string :contact
      t.string :default_items
    end
  end
end
