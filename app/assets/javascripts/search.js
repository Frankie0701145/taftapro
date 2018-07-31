$(document).on('turbolinks:load', function(){
	
  $inputer = $("[data-behavior='autocomplete']");

	var options = {
		getValue: "name",
		url: function(phrase){
			return "/search.json?q=" + phrase;
		},
		categories: [
			{
				listLocation: "home_improvement_services",
				header: "<strong>Home Improvement</strong>"
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