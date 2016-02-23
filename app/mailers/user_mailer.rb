class UserMailer < ActionMailer::Base
  layout 'mail_layout'
  before_filter :set_locale

    def invite(email,flat_name,token)
        @flat_name=flat_name
        @token=token
        mail(to: email)
    end

    def added_to_flat(user)
        @flat_name=user.flat.name
        mail(to: user.email)
    end

    private
    def set_locale
        default_url_options[:locale]= I18n.locale
    end

end
