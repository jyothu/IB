class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :name, null: false
      t.date :invoice_date
      t.string :vendor
      t.string :file
      t.integer :bucket_id, null: false
      t.integer :company_id, null: false

      t.timestamps null: false
    end
    add_index :invoices, [:name, :bucket_id, :company_id], unique: true
  end
end