class Api::ResourceentryController < Api::RestController
  def page
    # @r=Resource.calc(current_user.flat.resources);
    # logic model calc call
    resource = Resource.find_resource_with_user_constraint(params[:resource_id], current_user)
    resourceentries = Resource.calc(resource)
    from = Integer(params[:from] || 0)
    to = Integer(params[:to] || bills_of_all_users.length) - from
    @re = resourceentries.drop(from).take(to)
  end

  def create
    entry = Resourceentry.new(entry_params)
    r = Resource.find_resource_with_user_constraint(params[:resource_id], current_user)
    firstEntry = r.resourceentries.where(isFirst: true).first
    if firstEntry.date > entry.date
      respond_with_errors([t('.entryDate_before_startDate')])
    elsif r.resourceentries.where('date = ?', entry.date).all.count != 0
      respond_with_errors([t('.entryDate_exists')])
    else

      entry.resource = r
      entry.save!
      respond_with(entry, location: nil)
    end
  end

  def destroy
    Resourceentry.destroy_with_user_constraint(params[:id], params[:resource_id], current_user)
    respond_with(nil)
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    params.require(:resourceentry).permit(:date, :value)
  end
end
