$(document).on('turbolinks:load', function(){
	
  $inputer = $("[data-behavior='autocomplete']");

  // Categories should be in alphabetical order:
	// 1. Animals
	// 2. Business
	// 3. Carpentry
	// 4. Design and Web
	// 5. Events
	// 6. Home Improvement 
	// 7. Legal
	// 8. Lessons
	// 9. Mechanical
	// 10. Personal
	// 11. Photography
	// 12. Repair and Technical Support
	// 13. Security
	// 14. Transport

	var options = {
		getValue: "name",
		url: function(phrase){
			return "/search.json?q=" + phrase;
		},
		categories: [
			{
				listLocation: "animals_services",
				header: "<strong>Animals</strong>"
			},
			{
				listLocation: "business_services",
				header: "<strong>Business</strong>"
			},
			{
				listLocation: "carpentry_services",
				header: "<strong>Carpentry</strong>"
			},
			{
				listLocation: "design_and_web_services",
				header: "<strong>Design and Web</strong>"
			},
			{
				listLocation: "events_services",
				header: "<strong>Events</strong>"
			},												
			{
				listLocation: "home_improvement_services",
				header: "<strong>Home Improvement</strong>"
			},
			{
				listLocation: "legal_services",
				header: "<strong>Legal</strong>"
			},
			{
				listLocation: "lessons_services",
				header: "<strong>Lessons</strong>"
			},
			{
				listLocation: "mechanical_services",
				header: "<strong>Mechanical</strong>"
			},
			{
				listLocation: "personal_services",
				header: "<strong>Personal</strong>"
			},
			{
				listLocation: "photography_services",
				header: "<strong>Photography</strong>"
			},
			{
				listLocation: "repair_and_technical_support_services",
				header: "<strong>Repair and Technical Support</strong>"
			},
			{
				listLocation: "security_services",
				header: "<strong>Security</strong>"
			},
			{
				listLocation: "transport_services",
				header: "<strong>Transport</strong>"
			}																					
		],
		list: {
			match: {
				enabled: true
			}
		}

	}

	$inputer.easyAutocomplete(options);
});