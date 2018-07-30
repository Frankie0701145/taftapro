json.home_improvement_services do
  json.array!(@home_improvement_services) do |home_improvement_service|
  	json.name home_improvement_service.service
  end
end