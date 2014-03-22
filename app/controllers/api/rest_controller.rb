class Api::RestController < ProtectedController
    protect_from_forgery with: :null_session
    respond_to :json
    rescue_from Exception, with: :general_error
    rescue_from ActiveRecord::RecordInvalid, with: :respond_with_record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


    def respond_with_record_invalid(e)
        respond_with_errors(e.record.errors)
    end

    def respond_with_errors(errors)
      render :json => {:errors => errors}, :status => :unprocessable_entity
    end

    def record_not_found
        render :json => {:errors => ['resource not found']}, :status => :not_found
    end

    def general_error(error)
        puts error.message
        render :json => {:errors => ['general error. please try again later!']}, :status => :internal_server_error
    end
end
