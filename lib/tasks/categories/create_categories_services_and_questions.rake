class CategoriesServicesAndQuestions
  ## TO-DO: This rake task needs major refactoring:
  # Consider using private methods instead

  def self.invoke
	  # Category names 
	  category_names = ["Animals", "Business", "Carpentry", "Design and Web", "Events", "Home Improvement", 
	  					"Legal", "Lessons", "Mechanical", "Personal", "Photography", "Repair and Technical Support", 
	  					"Security", "Transport"].sort

	  # Services

	  def self.home_improvement_services
	  	["Domestic Workers", "Handy Man", "House Cleaning", "Car Cleaning",
	                              "Interior Design", "General Contracting", "Repair and Maintenance",
	                              "Plumbing", "Landscaping", "Electrical", "Home Painting", "Home Remodeling",
	                              "Carpet Cleaning","Lawn Mowing","Laundry"
	                            ].sort
	  end
	  
	  def self.animals_services 
	  	["Dog Walking/Running","Dog training", "Veterinary Services", "Animal Breeding"].sort
	  end

	  def self.events_services
	  	["DJ", "Wedding Officiant", "Toilet rental", "Event Photography", "Bartending",
	                      "Event Bouncer Services","Audio Equipment Rental For Events", "Entertainment",
	                      "Face Painting","Catering Services", "Decorations", "Transport", "Hypeman",
	                      "MC"
	                    ].sort                                           
	  end

	  def self.legal_services
	   ["Business Registartion", "Contracts Attorney", "Traffic Law Attorney", "Legal Document Preparation"].sort
	  end

	  def self.photography_services
	   ["Video Editing","Aerial Photography","Picture Framing", "Engagement Photography", "Wedding"].sort
	  end

	  def self.lessons_services 
	  	["Math Tutoring", "Piano Lessons", "Reading and Writting Tutoring","Guitar Lessons", "Self Defense Lessons"].sort
	  end

	  def self.design_and_web_services
	  	["Animation", "Graphic Design", "Logo Design","Business Cards", 
	                            "Mobile Software Developement", "UI development", "Software Development", "Printing"].sort
      end
	  
	  def self.transport_services
	   ["Taxi Services",
	                    "Truck Rental",
	                    "Guided Tours and Excursions",
	                    "Light transport",
	                    "Container Transport"].sort
	  end

	  def self.repair_and_technical_support_services 
	  	["Phone or Tablet Repair",
	                                  "TV Mounting",
	                                  "Vehicle repair",
	                                  "Computer repair",
	                                  "Data Recovery Services",
	                                  "Appliance Installation",
	                                  "Point of sale Repair",
	                                  "Network Support Services"].sort
      end

	  def self.mechanical_services 
	  	["Car Servicing (Oil and Filter Change)",
	                    "Tyre change",
	                    "Wheel alignment",
	                    "Battery boost ",
	                    "Vehicle Recovery and towing",
	                    "Car painting",
	                    "Car Tinting"].sort
      end

	  def self.personal_services
	   ["Anger Management",
	                "Delivery Services",
	                "Nannying"].sort
	  end

	  def self.security_services
	   ["Event Bouncers",
	                "Facility Bouncers",
	                "Residential Security",
	                "Security Equipment Installation",
	                "Bodyguard Services"].sort
	  end

	  def self.business_services
	   ["Surveyor",
	                "Accounting",
	                "Data Entry",
	                "Computer Repair",
	                "Logo Design",
	                "Data Recovery",
	                "Clearing and Forwarding",
	                "Marketting",
	                "Branding",
	                "HR and Payroll Services",
	                "Merchandising Services",
	                "Internet Provision",
	                "Customer Support"].sort
      end

	  def self.carpentry_services
	   ["Furniture Repairs",
	                "Furniture installation"].sort
      end

	  # Questions
	  
	  def self.home_improvement_questions
	  	[{ question: "Describe the nature of the service.", answer_type: "text_area" },
	                                          { question: "Which additional service do you want if any?", answer_type: "text_field" },
	                                          { question: "When do you need this service done – calendar?", answer_type: "date_field" },
	                                          { question: "Where can we send your matches?", answer_type: "email_field" }
	                                          ]
	  end
	  
	  def self.animals_questions
	   self.home_improvement_questions
	  end

	  def self.events_questions
	   [{question: "What is your role in the event", answer_type: "text_field"},
	               {question: "When do you need this service done", answer_type: "date_field"},
	               {question: "Additional information", answer_type: "text_area"},
	               {question: "How many guests do you expect", answer_type: "text_field"},
	               {question: "What type of event are you hosting", answer_type: "text_field"},
	               {question: "Is the event indoors or outdoors", answer_type: "text_field"},
	               {question: "What is the duration of the service", answer_type: "text_field"},
	               {question: "What is the type of venue", answer_type: "text_field"},
	               { question: "Where can we send your matches?", answer_type: "email_field" }
	              ]
      end

	  def self.legal_questions
	   [{question: "What legal service do you need help on", answer_type:"text_field"},
	                        {question:"Any additional Information", answer_type: "text_area"},
	                        {question: "What kind of service would you like Consultation, Representation", answer_type: "text_field"},
	                        { question: "Where can we send your matches?", answer_type: "email_field" }
	                      ]
      end
	  
	  def self.photography_questions 
	  	[{question: "Outline how you want it done", answer_type:"text_field"},
	                              {question: "Describe the specific service intersted in", answer_type:"text_area"},
	                              {question: "Any additional informatiion", answer_type:"text_area"},
	                              { question: "Where can we send your matches?", answer_type: "email_field" }
	                            ]
      end

	  def self.lessons_questions
	   [{question: "How old is the student",  answer_type:"text_field"},
	                          {question:"Does the student have any formal training", answer_type:"text_field"},
	                          {question: "What Specific areas do you want trained on", answer_type: "text_field"},
	                          {question: "How long should the lesson be", answer_type:"text_field"},
	                          {question: "How frequent should the leassons be.", answer_type:"text_field"},
	                          {question: "Additional Information", answer_type:"text_area"},
	                          {question: "Venue of the training", answer_type:"text_field"},
	                          {question: "Where can we send your matches", answer_type:"email_field"}
	                        ]
      end

	  def self.design_and_web_questions
	   [{question:"Outline how you want it done", answer_type:"text_area"},
	                                {question:"Any additional information", answer_type:"text_area"},
	                                {question:"Describe the specific service interested in", answer_type:"text_area"},
	                                {question: "Where can we send your matches?", answer_type:"email_field"}]
	  end 
	                             
	  def self.transport_questions 
	   self.design_and_web_questions
	  end

	  def self.repair_and_technical_support_questions 
	  	self.design_and_web_questions
	  end

	  def self.mechanical_questions
	   self.design_and_web_questions
	  end

	  def self.personal_questions 
	  	self.design_and_web_questions
	  end
	  
	  def self.security_questions
	   self.events_questions
	  end

	  def self.business_questions
	   self.mechanical_questions
	  end
	  
	  def self.carpentry_questions
	   self.mechanical_questions
      end

    category_names.each do |category_name|
      # Convert to downcase and changes the whitespace to underscores before appending _services and _questions
      services = send("#{category_name.downcase.tr(" ", "_")}_services")
      questions = send("#{category_name.downcase.tr(" ", "_")}_questions")
      Category.inputter(category_name, services, questions)
    end
  end
end

namespace :categories do
	desc "Create categories, associated services, and questions"
	task :create_categories_services_and_questions => :environment do
		CategoriesServicesAndQuestions.invoke	
	end
end
