class AddPhoneToCustomerEntries < ActiveRecord::Migration
  def change
    add_column :customer_entries, :phone, :string
  end
end
