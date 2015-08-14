class Company < ActiveRecord::Base
	has_many :users, dependent: :destroy
	has_many :invoices, dependent: :destroy
	has_many :buckets, dependent: :destroy
	accepts_nested_attributes_for :users, :reject_if => :all_blank, :allow_destroy => true
  
  before_create :set_email
	after_create :add_invoicebarrack_bucket

	def add_invoicebarrack_bucket
		self.buckets.create!(name: "Invoice Barrack")
	end

	def set_email
		self.email = self.name.split.first.downcase+"@invoicebarrack.in"
	end
end
