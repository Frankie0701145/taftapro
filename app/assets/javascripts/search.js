document.addEventListener("turbolinks:load", function(){
  $input = $("[data-behavior='autocomplete']");

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
		]
	}

	$input.easyAutocomplete(options);
});