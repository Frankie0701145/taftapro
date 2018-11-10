# frozen_string_literal: true

class SearchServiceByLocationForm
  include ActiveModel::Model

  attr_accessor :service, :location, :q

  def initialize(service: nil, params: {})
    @service = params[:q]
  end
end
