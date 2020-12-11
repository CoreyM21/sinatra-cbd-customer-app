class CreateCustomerEntries < ActiveRecord::Migration
  def change
    create_table :customer_entries do |t|

      t.timestamps null: false
    end
  end
end
