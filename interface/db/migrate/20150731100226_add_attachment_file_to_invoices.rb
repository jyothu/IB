class AddAttachmentFileToInvoices < ActiveRecord::Migration
  def self.up
    change_table :invoices do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :invoices, :file
  end
end
