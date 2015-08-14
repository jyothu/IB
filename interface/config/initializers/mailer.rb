# SMTP settings for gmail
ActionMailer::Base.smtp_settings = {
	:address => "smtp.gmail.com",
	:domain => "gmail.com",
	:port => 587,
	:user_name => "invoice.barrack@gmail.com",
	:password => 'invoice@1234',
	:authentication => "plain",
  :enable_starttls_auto => true
}

# invoices@invoicebarrack.in/InvoiceBarrack
