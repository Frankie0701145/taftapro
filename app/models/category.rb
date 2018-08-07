# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  service    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  has_many :questions
    

    #Home Improvement
    @@home_improvement_services = ["Domestic Workers",
    								"Handy Man",
    								"House Cleaning",
    								"Car Cleaning",
    								"Interior Design",
    								"General Contracting",
    								"Repair and Maintenance",
    								"Plumbing",
    								"Landscaping",
    								"Electrical",
    								"Home Painting",
    								"Home remodeling",
    								"Carpet cleaning",
    								"Lawn mowing",
    								"Laundry"]
    #Animal
    @@animals = ["Dog Walking/Running",
                 "Dog training",
                 "Veterinary Services",
                 "Animal Breeding"]
    #Events
    @@events =  ["DJ",
                  "Wedding Officiant",
                  "Toilet rental",
                  "Event Photography",
                  "Bartending",
                  "Event Bouncer Services",
                  "Audio Equipment Rental For Events",
                  "Entertainment",
                  "Face Painting",
                  "Catering Services",
                  "Decorations",
                  "Transport",
                  "Hypeman",
                  "MC"
                  ]
    #Legal
    @@legal = ["Business Registartion",
                "Contracts Attorney",
                "Traffic Law Attorney",
                "Legal Document Preparation"]
    #Photography
    @@photography = ["Video Editing",
                      "Aerial Photography",
                      "Picture Framing",
                      "Engagement Photography",
                      "Wedding",
                    ]
    #Lessons
    @@lessons = ["Math Tutoring",
                  "Piano Lessons",
                  "Reading and Writting Tutoring",
                  "Guitar Lessons",
                  "Self Defense Lessons",
                  ]
    #Design and Web
    @@design_and_web = ["Animation",
                        "Graphic Design",
                        "Logo Design",
                        "Business Cards",
                        "Mobile Software Developement",
                        "UI development",
                        "Software Development",
                        "Printing"]
    #Transport
    @@transport = ["Taxi Services",
                    "Truck Rental",
                    "Guided Tours and Excursions",
                    "Light transport",
                    "Container Transport"]
    #Repair and Technical Support
    @@repair_technical_support = ["Phone or Tablet Repair",
                                  "TV Mounting",
                                  "Vehicle repair",
                                  "Computer repair",
                                  "Data Recovery Services",
                                  "Appliance Installation",
                                  "Point of sale Repair",
                                  "Network Support Services"]
    #Mechanical
    @@mechanical =["Car Servicing (Oil and Filter Change)",
                    "Tyre change",
                    "Wheel alignment",
                    "Battery boost ",
                    "Vehicle Recovery and towing",
                    "Car painting",
                    "Car Tinting"]
    #Personal
    @@personal = ["Anger Management",
                  "Delivery Services",
                  "Nannying"]
    #Security
    @@security = ["Event Bouncers",
                  "Facility Bouncers",
                  "Residential Security",
                  "Security Equipment Installation",
                  "Bodyguard Services"]
    #Business
    @@business = ["Surveyor",
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
                  "Customer Support"]
    #Carpentry
    @@carpentry = ["Furniture Repairs",
                  "Furniture installation"]

  #Questions
  @@home_improvement_service_questions=[{ question: "Describe the nature of the service.", answer_type: "text_area" },
                                          { question: "Which additional service do you want if any?", answer_type: "text_field" },
                                          { question: "When do you need this service done – calendar?", answer_type: "date_field" },
                                          { question: "Where can we send your matches?", answer_type: "email_field" }
                                          ]
  @@animals_questions = @@home_improvement_service_questions

  @@events_questions  = [{question: "What is your role in the event", answer_type: "text_field"},
               {question: "When do you need this service done", answer_type: "date_field"},
               {question: "Additional information", answer_type: "text_area"},
               {question: "How many guests do you expect", answer_type: "text_field"},
               {question: "What type of event are you hosting", answer_type: "text_field"},
               {question: "Is the event indoors or outdoors", answer_type: "text_field"},
               {question: "What is the duration of the service", answer_type: "text_field"},
               {question: "What is the type of venue", answer_type: "text_field"},
               { question: "Where can we send your matches?", answer_type: "email_field" }
              ]

  @@legal_questions = [{question: "What legal service do you need help on", answer_type:"text_field"},
                        {question:"Any additional Information", answer_type: "text_area"},
                        {question: "What kind of service would you like Consultation, Representation", answer_type: "text_field"},
                        { question: "Where can we send your matches?", answer_type: "email_field" }
                      ]

  @@photography_questions = [{question: "Outline how you want it done", answer_type:"text_field"},
                              {question: "Describe the specific service intersted in", answer_type:"text_area"},
                              {question: "Any additional informatiion", answer_type:"text_area"},
                              { question: "Where can we send your matches?", answer_type: "email_field" }
                            ]

  @@lessons_questions = [{question: "How old is the student",  answer_type:"text_field"},
                          {question:"Does the student have any formal training", answer_type:"text_field"},
                          {question: "What Specific areas do you want trained on", answer_type: "text_field"},
                          {question: "How long should the lesson be", answer_type:"text_field"},
                          {question: "How frequent should the leassons be.", answer_type:"text_field"},
                          {question: "Additional Information", answer_type:"text_area"},
                          {question: "Venue of the training", answer_type:"text_field"},
                          {question: "Where can we send your matches", answer_type:"email_field"}
                        ]

  @@design_and_web_questions = [{question:"Outline how you want it done", answer_type:"text_area"},
                                {question:"Any additional information", answer_type:"text_area"},
                                {question:"Describe the specific service interested in", answer_type:"text_area"},
                                { question: "Where can we send your matches?", answer_type:"email_field"}
                              ]
  @@transport_questions = @@design_and_web_questions

  @@repair_and_technical_support_questions = @@design_and_web_questions

  @@mechanical_questions = @@design_and_web_questions

  @@personal_questions = @@design_and_web_questions

  @@security_questions = @@events_questions

  @@business_questions = @@mechanical_questions

  @@carpentry_questions = @@mechanical_questions

  def self.inputter category_name, arr_services , arr_questions
     arr_services.each do |service|
       service_category = Category.find_or_create_by(name:category_name, service:service)

       if service_category
          arr_questions.each do |question_obj|
            question_one =
                Question.find_by(
                  question: question_obj["question".to_sym],
                  category_id: service_category.id
                  ) ||
                service_category.questions.build(question: question_obj["question".to_sym], answer_type: question_obj["answer_type".to_sym])
          end
          service_category.save
       end
     end
  end

  def self.create_home_improvement_category
  	first_question = { question: "Describe the nature of the service.", answer_type: "text_area" }
  	second_question = { question: "Which additional service do you want if any?", answer_type: "text_field" }
  	third_question = { question: "When do you need this service done – calendar?", answer_type: "date_field" }
  	last_question = { question: "Where can we send your matches?", answer_type: "email_field" }

  	@@home_improvement_services.each do |home_improvement_service|
	    home_improvement_category = Category.find_or_create_by(name: "Home Improvement", service: home_improvement_service)

	    if home_improvement_category
	      question_one =
	        Question.find_by(
	        	question: first_question["question".to_sym],
	        	category_id: home_improvement_category.id
	        	) ||
	        home_improvement_category.questions.build(question: first_question["question".to_sym], answer_type: first_question["answer_type".to_sym])

	      question_two =
	        Question.find_by(
	        	question: second_question["question"],
	        	category_id: home_improvement_category.id
	        	) ||
	      	home_improvement_category.questions.build(question: second_question["question".to_sym], answer_type: second_question["answer_type".to_sym])

		  question_three =
	        Question.find_by(
	        	question: third_question["question"],
	        	category_id: home_improvement_category.id
	        	) ||
	      	home_improvement_category.questions.build(question: third_question["question".to_sym], answer_type: third_question["answer_type".to_sym])

	      question_last =
	        Question.find_by(
	        	question: last_question["question"],
	        	category_id: home_improvement_category.id
	        	) ||
	      	home_improvement_category.questions.build(question: last_question["question".to_sym], answer_type: last_question["answer_type".to_sym])

	      home_improvement_category.save
	    end
    end
  end


  def self.home_improvement_category
  	Category.find_by(name: "Home Improvement")
  end

end
