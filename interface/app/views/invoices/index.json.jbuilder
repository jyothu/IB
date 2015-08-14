json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :name, :month, :type, :vendor, :file, :company_id
  json.url invoice_url(invoice, format: :json)
end
