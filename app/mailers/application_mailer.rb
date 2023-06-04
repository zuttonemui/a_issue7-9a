class ApplicationMailer < ActionMailer::Base
  default from: 'from: ENV["KEY"]'
  layout 'mailer'
end
