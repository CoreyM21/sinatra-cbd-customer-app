class AddTitleToCustomerEntries < ActiveRecord::Migration
  def change
    add_column :customer_entries, :title, :string
  end
end
