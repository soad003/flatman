class UserMailer < ActionMailer::Base
  layout 'mail_layout'
  before_filter :set_locale

    def invite(email,flat_name,token,flat_token)
        @flat_name=flat_name
        @token=token
        @flat_token=flat_token
        mail(to: email)
    end

    private
    def set_locale
        default_url_options[:locale]= I18n.locale
    end

end
