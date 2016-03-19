class Utility
  # Logs and emails exception
  # Optional args:
  # request: request Used for the ExceptionNotifier
  # info: "A descriptive messsage"
  def self.log_exception(e, args)
    extra_info = args[:info]

    Rails.logger.error extra_info if extra_info
    Rails.logger.error e.message
    st = e.backtrace.join("\n")
    Rails.logger.error st

    extra_info ||= '<NO DETAILS>'
    request = args[:request]
    env = request ? request.env : nil
    if env
      ExceptionNotifier::Notifier
        .exception_notification(env, e, data: { message: "Exception: #{extra_info}" })
        .deliver
    else
      ExceptionNotifier::Notifier
        .background_exception_notification(e, data: { message: "Exception: #{extra_info}" })
        .deliver
    end
  end
end
