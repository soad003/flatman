=begin
scheduler = Rufus::Scheduler.new

# every day 6am
scheduler.cron("0 06 * * *") do
  # connection in worker in with_connection to aviod connection pool exaustment
  # http://www.sitepoint.com/simple-background-jobs-with-sucker-punch/
    ActiveRecord::Base.connection_pool.with_connection do
        begin
            #DecisionsController.new.close_expired_and_inform_user
        rescue => e
            ExceptionNotifier.notify_exception(e)
        end
    end

end
=end
