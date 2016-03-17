class PublicController < ApplicationController
  layout 'welcome', :only => [ :welcome ]
  
  def about
  end

  def contact
  end

  def terms_and_privacy
  end

  def welcome
  end
end
