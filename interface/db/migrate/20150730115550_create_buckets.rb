class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :name, null: false
      t.integer :company_id, null: false

      t.timestamps null: false
    end
    add_index :buckets, [:name, :company_id], unique: true
  end
end
