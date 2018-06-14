class SearchServiceByLocationForm
	include ActiveModel::Model

	attr_accessor :service, :location

	def initialize(service: nil, params: {})
		@service = service
	end
end