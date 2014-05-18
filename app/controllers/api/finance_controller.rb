class Api::FinanceController <Api::RestController
	around_filter :wrap_in_transaction, only: [:create, :update]

        #change to where user_id
	  def index
		    @f=Bill.all
        #@b=Bill.group(:billcategory_id).sum(:value)
        #ctg=Billcategory.all
        #@cgy=Billcategory.merge_value(@f, ctg)
    end

    def create
        ct=Billcategory.new()
        @bill=Bill.new(f_params)
        ct.name = params_all[:cat_name]
        @allCat = Billcategory.all
        id = Billcategory.check_unique(@allCat, ct)
        if id == 0
          ct.save!
          @bill.billcategory_id = ct.id
        else
          @bill.billcategory_id = id
        end
        @bill.user_id = current_user.id
        @bill.save!
        #payment
        #check who is envolved in paying
        mates = []
        cost = params_all[:value]
        flat = current_user.flat
        flat_id = flat.id
        members = User.all
        members.each do |m|
            if m.id == flat_id
                mates << m.id
            end
        end
        payee_id = [];
        if params_all[:payee1] == true
          payee_id << mates[0];
        end
        if params_all[:payee2] == true
          payee_id << mates[1];
        end
        if params_all[:payee3] == true
          payee_id << mates[2];
        end
        if params_all[:payee4] == true
          payee_id << mates[3];
        end
        if params_all[:payee5] == true
          payee_id << mates[4];
        end

        if payee_id.length != 0
          cost = params_all[:value]/payee_id.length
        end

        payee_id.each do |p|
          @payment = Payment.new()
          @payment.payer_id = params_all[:payer]
          @payment.date = params_all[:date]
          @payment.payee_id = p.id
          @payment.value = cost
          @payment.save!
        end
    end

    def update

    end

    def destroy
       entry = Bill.find(f_params[:id])
       entry.destroy!
       respond_with(nil)
    end

    #change all to user_id
    def get_all
        @catName=Billcategory.all
        billName = []
        bil=Bill.all
        bil.each do |b|
          billName << Billcategory.find(b.billcategory_id).name
        end

        @catName.each do |c|
          if !billName.include?(c.name)
            @catName.delete(c)
          end
        end
        @name=Bill.includes(:billcategory).group("billcategories.name").sum(:value)
    end

    def get_ctg

    end

    #user_id
    def get_chart
        @chart = Bill.all
    end

    def get_debts
      @cu = current_user
      @pmnt = Payment.get_users_payments(@cu)
    end

    #user_id
    def create_debt
      cu = current_user
      @bl = Bill.all
      #all bills where current user is payee
      payee= Bill.get_payees(@bl, cu)
      #all bills where user must pay
      payer=Bill.get_payers(@bl, cu)
      #value = Bill.get_values_of_debts(payee, payer)
      #@payment = Payment.new()
      #zuweisung parameter
      respond_with(nil);
    end
    
    def get_month
      #@mon = Bill.
      respond_with(nil)
    end

    def pay_debt

    end

    #change: now userid compared to flatid
    #oauth_token filtern
    def get_mates
        returnList = []
        flat = current_user.flat
        flat_id = flat.id
        members = User.all
        members.each do |m|
            if m.id == flat_id
                returnList << m
            end
        end
        @mem = returnList
        respond_with(@mem);
    end

    private
    def f_params
        params.permit(:text, :value,:user_id, :date, :billcategory_id, :id)
    end

    private
    def params_all
        params.permit(:text, :value,:user_id, :date, :cat_name, :payer, :payee1, :payee2, :payee3, :payee4, :payee5)
    end
end