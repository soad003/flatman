class Api::RestController < ProtectedController
    protect_from_forgery with: :null_session
    respond_to :json
    rescue_from ActiveRecord::RecordInvalid, with: :respond_with_record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def respond_with_record_invalid(e)
        respond_with_errors(e.record.errors)
    end

    def respond_with_errors(errors)
      render :json => {:errors => errors}, :status => :bad_request
    end

    def record_not_found
        render :json => {:errors => ['resource not found']}, :status => 404
    end
end
