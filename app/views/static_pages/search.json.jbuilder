json.animals_services do
  json.array!(@animals_services) do |animals_service|
  	json.name animals_service.service
  end
end

json.business_services do
  json.array!(@business_services) do |business_service|
  	json.name business_service.service
  end
end

json.carpentry_services do
  json.array!(@carpentry_services) do |carpentry_service|
  	json.name carpentry_service.service
  end
end

json.design_and_web_services do
  json.array!(@design_and_web_services) do |design_and_web_service|
  	json.name design_and_web_service.service
  end
end

json.events_services do
  json.array!(@events_services) do |events_service|
  	json.name events_service.service
  end
end

json.home_improvement_services do
  json.array!(@home_improvement_services) do |home_improvement_service|
  	json.name home_improvement_service.service
  end
end

json.legal_services do
  json.array!(@legal_services) do |legal_service|
  	json.name legal_service.service
  end
end

json.lessons_services do
  json.array!(@lessons_services) do |lessons_service|
  	json.name lessons_service.service
  end
end

json.mechanical_services do
  json.array!(@mechanical_services) do |mechanical_service|
  	json.name mechanical_service.service
  end
end

json.personal_services do
  json.array!(@personal_services) do |personal_service|
  	json.name personal_service.service
  end
end

json.photography_services do
  json.array!(@photography_services) do |photography_service|
  	json.name photography_service.service
  end
end

json.repair_and_technical_support_services do
  json.array!(@repair_and_technical_support_services) do |repair_and_technical_support_service|
  	json.name repair_and_technical_support_service.service
  end
end

json.security_services do
  json.array!(@security_services) do |security_service|
  	json.name security_service.service
  end
end

json.transport_services do
  json.array!(@transport_services) do |transport_service|
  	json.name transport_service.service
  end
end
