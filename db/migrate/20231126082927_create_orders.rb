class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :order_uniq_id, null: false
      t.string :customer_name
      t.float :total_in_cents
      t.datetime :ordered_at
      t.references :customer, null: false
      
      t.timestamps
      t.index :order_uniq_id, unique: true
    end
  end
end
