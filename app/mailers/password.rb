class Password < ActionMailer::Base
  include Devise::Mailers::Helpers

  def reset_password_instructions(record,user_req)
    devise_mail(record, :reset_password_instructions)
  end

end
