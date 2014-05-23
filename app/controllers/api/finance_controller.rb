class Api::FinanceController <Api::RestController

        #change to where user_id
	  def index
		    @f=Bill.where(:user_id => current_user.id)
        #@b=Bill.group(:billcategory_id).sum(:value)
        #ctg=Billcategory.all
        #@cgy=Billcategory.merge_value(@f, ctg)
    end

    #change all to user_id
    def get_all
        @catName=Billcategory.all         #change all
        billName = []
        bil=Bill.where(:user_id => current_user.id)                      #change all
        bil.each do |b|
          billName << Billcategory.find(b.billcategory_id).name
        end

        # wieso werden hier categorien gelöscht
        # @catName.each do |c|
        #   if !billName.include?(c.name)
        #     @catName.delete(c)
        #   end
        # end
        @name=Bill.includes(:billcategory).group("billcategories.name").sum(:value)
    end

    def get_finance_tables
      @userTables = Finance.getUserTables(current_user)
    end

    def get_ctg

    end

    #user_id
    def get_chart
        @chart = Bill.where(:user_id => current_user.id)
    end

    def get_debts
      @cu = current_user
      @pmnt = Payment.get_users_payments(@cu)
    end

    #not needed
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

    #oauth_token filtern
    def get_mates
        returnList = []
        flat = current_user.flat
        flat_id = flat.id
        members = User.all
        members.each do |m|
            if m.flat_id == flat_id
                returnList << m
            end
        end
        @mem = returnList
        respond_with(@mem);
    end
end
