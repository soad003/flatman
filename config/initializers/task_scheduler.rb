scheduler = Rufus::Scheduler.new

scheduler.every("1m") do
    # connection in worker in with_connection to aviod connection pool exaustment
    # http://www.sitepoint.com/simple-background-jobs-with-sucker-punch/
    #ActiveRecord::Base.connection_pool.with_connection do
    #    begin
           #do something usefull
   #     rescue => e
           # ExceptionNotifier.notify_exception(e)
   #     end
   # end
end
