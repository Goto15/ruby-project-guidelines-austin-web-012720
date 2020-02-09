class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.string :title
      t.string :url
      t.string :hd_url
      t.string :explanation
      t.datetime :date
    end
  end
end