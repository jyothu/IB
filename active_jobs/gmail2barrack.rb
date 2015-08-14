require File.expand_path('../../interface/config/environment',  __FILE__)
class Gmail2IB
  puts "Establishing connection with TECH Mailbox..."
  begin
    tries ||= 2
    GMAIL = Gmail.new('invoices@invoicebarrack.in', 'R9g1yu505I2a')
  rescue Exception => e
    puts "Connection Error: #{e.message}. Retrying..."
    retry unless (tries -= 1).zero?
    puts "Sorry! Couldn't establish a connection to Gmail Account. Exiting..."
    exit
  end
end

def make_pdf(mail)
  file_name = "#{IB::BARRACK}/#{mail.subject.gsub(' ', '_')}.pdf"
  puts file_name.inspect
  html = (mail.html_part or mail.text_part or mail).body.decoded
  chareset = mail.text_part ? mail.text_part.charset : (mail.html_part ? mail.html_part.charset : "ISO-8859-1")
  kit = PDFKit.new(html.force_encoding(chareset).encode("UTF-8"), :page_size => 'Letter')
  begin 
    puts kit.to_file(file_name)
  rescue
    nil
  end
  file_name
end

def save_attachments(attachments)
  file = nil
  attachments.each do |attachment|
    next if attachment.blank?
    file = File.new(IB::BARRACK + attachment.filename, "w+")
    chareset = attachment.text_part ? attachment.text_part.charset : (attachment.html_part ? attachment.html_part.charset : "UTF-8")
    file << attachment.decoded.force_encoding(chareset).encode("UTF-8")
  end
  file
end

puts "Collecting Emails from TECH Mailbox..."
Gmail2IB::GMAIL.inbox.emails(:unread).first(5).each do |mail|
  puts mail.subject
	bucket_name = mail.from.first.split("@").last.split(".").first
  company = Company.last # TODO to find company from to address
  puts bucket = company.buckets.find_or_create_by(:name => bucket_name.upcase)
  invoice_file = mail.attachments.any? ? save_attachments(mail.attachments) : make_pdf(mail)

  params = {
    invoice_date: mail.message.date,
    name: mail.subject,
    bucket: bucket,
    vendor: bucket_name,
    file: File.open(invoice_file)
  }
  company.invoices.create(params)
end

