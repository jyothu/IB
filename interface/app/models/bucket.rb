class Bucket < ActiveRecord::Base
	belongs_to :company
	has_many :invoices, dependent: :destroy
end
