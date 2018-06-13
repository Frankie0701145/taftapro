class StaticPagesController < ApplicationController
  def home
  	@search_form = SearchServiceByLocationForm.new
  end

  def search_service
  end

  def about
  end
end
