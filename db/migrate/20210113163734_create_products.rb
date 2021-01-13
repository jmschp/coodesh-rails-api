class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.string :category, null: false
      t.text :description
      t.decimal :price, null: false, default: 0
      t.integer :rating, null: false, default: 0

      t.timestamps
    end
  end
end
