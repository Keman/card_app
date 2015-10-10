Paperclip::Attachment.default_options[:url] = ":s3_domain_url"
Paperclip::Attachment.default_options[:path] = "/:class/:attachment/:id_partition/:style/:filename"
Paperclip::Attachment.default_options[:access_key_id] = ENV["s3_key"]
Paperclip::Attachment.default_options[:secret_access_key] = ENV["s3_secret"]
