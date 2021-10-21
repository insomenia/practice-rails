class CreateLineItems < ActiveRecord::Migration[6.0]
  def change
    create_table :line_items do |t|
      t.references :order, null: false
      t.integer :status
      t.integer :quantity
      t.integer :total

      t.timestamps
    end
  end
end
