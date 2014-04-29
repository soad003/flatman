class Api::FinanceController <Api::RestController
	around_filter :wrap_in_transaction, only: [:create, :update]

	  def index
		  @f=Bill.all
      #@f.each do |b|
      #  b.name = Billcategory.find(b.billcategory_id)
      #end

      #respond_with(@f)
    end

    def create
        #f=Billcategory.all
        #f_params[:billcategory_id] = f.id
        b=Bill.new(f_params)
        b.billcategory_id = "1";
        b.save!
        respond_with(b, :location => nil);
    end

    def update

    end

    def destroy
       entry = Bill.find(f_params[:id])
       entry.destroy!
       respond_with(nil)

       #Bill.destroy_with_user_constraint(params[:id], current_user)
       #respond_with(nil)
    end

    private
    def f_params
        params.permit(:text, :value, :user_id, :date, :billcategory_id, :id)
    end

    private
    def b_params
      params.permit(:id, :name)
    end
end