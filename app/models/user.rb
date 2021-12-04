require 'securerandom'

class User < ApplicationRecord
	validates_presence_of :from_country, :address, :work, :budget, :zip_code, :latitude, :longitude
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
		   :recoverable, :rememberable, :validatable
	enum work: { student: 0, professional: 1 }

	cattr_reader :questions, :types, :placeholders, :countries
	@@questions = {
		from_country: "Which country are you coming from?",
		address: "Which city are you traveling to?",
		work: "What is your work category?",
		budget: "What is your budget?",
		latitude: "",
		longitude: ""
	}
	@@types = {
	 	from_country: :string,
    	address: :string,
	  	work: :integer,
	  	budget: :integer,
    	zip_code: :integer,
    	latitude: :float,
    	longitude: :float
	}
	@@placeholders = {
		from_country: "India",
		address: "2960 Broadway",
		work: "Student/Professional",
		budget: "2000"
	}

	@@countries = [
		["Select Country", "Select Country"],
		["Afghanistan", "Afghanistan"],
		["Albania", "Albania"],
		["Algeria", "Algeria"],
		["American Samoa", "American Samoa"],
		["Andorra", "Andorra"],
		["Angola", "Angola"],
		["Anguilla", "Anguilla"],
		["Antarctica", "Antarctica"],
		["Antigua and Barbuda", "Antigua and Barbuda"],
		["Argentina", "Argentina"],
		["Armenia", "Armenia"],
		["Aruba", "Aruba"],
		["Australia", "Australia"],
		["Austria", "Austria"],
		["Azerbaijan", "Azerbaijan"],
		["Bahamas (the)", "Bahamas (the)"],
		["Bahrain", "Bahrain"],
		["Bangladesh", "Bangladesh"],
		["Barbados", "Barbados"],
		["Belarus", "Belarus"],
		["Belgium", "Belgium"],
		["Belize", "Belize"],
		["Benin", "Benin"],
		["Bermuda", "Bermuda"],
		["Bhutan", "Bhutan"],
		["Bolivia (Plurinational State of)", "Bolivia (Plurinational State of)"],
		["Bonaire, Sint Eustatius and Saba", "Bonaire, Sint Eustatius and Saba"],
		["Bosnia and Herzegovina", "Bosnia and Herzegovina"],
		["Botswana", "Botswana"],
		["Bouvet Island", "Bouvet Island"],
		["Brazil", "Brazil"],
		["British Indian Ocean Territory (the)", "British Indian Ocean Territory (the)"],
		["Brunei Darussalam", "Brunei Darussalam"],
		["Bulgaria", "Bulgaria"],
		["Burkina Faso", "Burkina Faso"],
		["Burundi", "Burundi"],
		["Cabo Verde", "Cabo Verde"],
		["Cambodia", "Cambodia"],
		["Cameroon", "Cameroon"],
		["Canada", "Canada"],
		["Cayman Islands (the)", "Cayman Islands (the)"],
		["Central African Republic (the)", "Central African Republic (the)"],
		["Chad", "Chad"],
		["Chile", "Chile"],
		["China", "China"],
		["Christmas Island", "Christmas Island"],
		["Cocos (Keeling) Islands (the)", "Cocos (Keeling) Islands (the)"],
		["Colombia", "Colombia"],
		["Comoros (the)", "Comoros (the)"],
		["Congo (the Democratic Republic of the)", "Congo (the Democratic Republic of the)"],
		["Congo (the)", "Congo (the)"],
		["Cook Islands (the)", "Cook Islands (the)"],
		["Costa Rica", "Costa Rica"],
		["Croatia", "Croatia"],
		["Cuba", "Cuba"],
		["Curaçao", "Curaçao"],
		["Cyprus", "Cyprus"],
		["Czechia", "Czechia"],
		["Côte d'Ivoire", "Côte d'Ivoire"],
		["Denmark", "Denmark"],
		["Djibouti", "Djibouti"],
		["Dominica", "Dominica"],
		["Dominican Republic (the)", "Dominican Republic (the)"],
		["Ecuador", "Ecuador"],
		["Egypt", "Egypt"],
		["El Salvador", "El Salvador"],
		["Equatorial Guinea", "Equatorial Guinea"],
		["Eritrea", "Eritrea"],
		["Estonia", "Estonia"],
		["Eswatini", "Eswatini"],
		["Ethiopia", "Ethiopia"],
		["Falkland Islands (the) [Malvinas]", "Falkland Islands (the) [Malvinas]"],
		["Faroe Islands (the)", "Faroe Islands (the)"],
		["Fiji", "Fiji"],
		["Finland", "Finland"],
		["France", "France"],
		["French Guiana", "French Guiana"],
		["French Polynesia", "French Polynesia"],
		["French Southern Territories (the)", "French Southern Territories (the)"],
		["Gabon", "Gabon"],
		["Gambia (the)", "Gambia (the)"],
		["Georgia", "Georgia"],
		["Germany", "Germany"],
		["Ghana", "Ghana"],
		["Gibraltar", "Gibraltar"],
		["Greece", "Greece"],
		["Greenland", "Greenland"],
		["Grenada", "Grenada"],
		["Guadeloupe", "Guadeloupe"],
		["Guam", "Guam"],
		["Guatemala", "Guatemala"],
		["Guernsey", "Guernsey"],
		["Guinea", "Guinea"],
		["Guinea-Bissau", "Guinea-Bissau"],
		["Guyana", "Guyana"],
		["Haiti", "Haiti"],
		["Heard Island and McDonald Islands", "Heard Island and McDonald Islands"],
		["Holy See (the)", "Holy See (the)"],
		["Honduras", "Honduras"],
		["Hong Kong", "Hong Kong"],
		["Hungary", "Hungary"],
		["Iceland", "Iceland"],
		["India", "India"],
		["Indonesia", "Indonesia"],
		["Iran (Islamic Republic of)", "Iran (Islamic Republic of)"],
		["Iraq", "Iraq"],
		["Ireland", "Ireland"],
		["Isle of Man", "Isle of Man"],
		["Israel", "Israel"],
		["Italy", "Italy"],
		["Jamaica", "Jamaica"],
		["Japan", "Japan"],
		["Jersey", "Jersey"],
		["Jordan", "Jordan"],
		["Kazakhstan", "Kazakhstan"],
		["Kenya", "Kenya"],
		["Kiribati", "Kiribati"],
		["Korea (the Democratic People's Republic of)", "Korea (the Democratic People's Republic of)"],
		["Korea (the Republic of)", "Korea (the Republic of)"],
		["Kuwait", "Kuwait"],
		["Kyrgyzstan", "Kyrgyzstan"],
		["Lao People's Democratic Republic (the)", "Lao People's Democratic Republic (the)"],
		["Latvia", "Latvia"],
		["Lebanon", "Lebanon"],
		["Lesotho", "Lesotho"],
		["Liberia", "Liberia"],
		["Libya", "Libya"],
		["Liechtenstein", "Liechtenstein"],
		["Lithuania", "Lithuania"],
		["Luxembourg", "Luxembourg"],
		["Macao", "Macao"],
		["Madagascar", "Madagascar"],
		["Malawi", "Malawi"],
		["Malaysia", "Malaysia"],
		["Maldives", "Maldives"],
		["Mali", "Mali"],
		["Malta", "Malta"],
		["Marshall Islands (the)", "Marshall Islands (the)"],
		["Martinique", "Martinique"],
		["Mauritania", "Mauritania"],
		["Mauritius", "Mauritius"],
		["Mayotte", "Mayotte"],
		["Mexico", "Mexico"],
		["Micronesia (Federated States of)", "Micronesia (Federated States of)"],
		["Moldova (the Republic of)", "Moldova (the Republic of)"],
		["Monaco", "Monaco"],
		["Mongolia", "Mongolia"],
		["Montenegro", "Montenegro"],
		["Montserrat", "Montserrat"],
		["Morocco", "Morocco"],
		["Mozambique", "Mozambique"],
		["Myanmar", "Myanmar"],
		["Namibia", "Namibia"],
		["Nauru", "Nauru"],
		["Nepal", "Nepal"],
		["Netherlands (the)", "Netherlands (the)"],
		["New Caledonia", "New Caledonia"],
		["New Zealand", "New Zealand"],
		["Nicaragua", "Nicaragua"],
		["Niger (the)", "Niger (the)"],
		["Nigeria", "Nigeria"],
		["Niue", "Niue"],
		["Norfolk Island", "Norfolk Island"],
		["Northern Mariana Islands (the)", "Northern Mariana Islands (the)"],
		["Norway", "Norway"],
		["Oman", "Oman"],
		["Pakistan", "Pakistan"],
		["Palau", "Palau"],
		["Palestine, State of", "Palestine, State of"],
		["Panama", "Panama"],
		["Papua New Guinea", "Papua New Guinea"],
		["Paraguay", "Paraguay"],
		["Peru", "Peru"],
		["Philippines (the)", "Philippines (the)"],
		["Pitcairn", "Pitcairn"],
		["Poland", "Poland"],
		["Portugal", "Portugal"],
		["Puerto Rico", "Puerto Rico"],
		["Qatar", "Qatar"],
		["Republic of North Macedonia", "Republic of North Macedonia"],
		["Romania", "Romania"],
		["Russian Federation (the)", "Russian Federation (the)"],
		["Rwanda", "Rwanda"],
		["Réunion", "Réunion"],
		["Saint Barthélemy", "Saint Barthélemy"],
		["Saint Helena, Ascension and Tristan da Cunha", "Saint Helena, Ascension and Tristan da Cunha"],
		["Saint Kitts and Nevis", "Saint Kitts and Nevis"],
		["Saint Lucia", "Saint Lucia"],
		["Saint Martin (French part)", "Saint Martin (French part)"],
		["Saint Pierre and Miquelon", "Saint Pierre and Miquelon"],
		["Saint Vincent and the Grenadines", "Saint Vincent and the Grenadines"],
		["Samoa", "Samoa"],
		["San Marino", "San Marino"],
		["Sao Tome and Principe", "Sao Tome and Principe"],
		["Saudi Arabia", "Saudi Arabia"],
		["Senegal", "Senegal"],
		["Serbia", "Serbia"],
		["Seychelles", "Seychelles"],
		["Sierra Leone", "Sierra Leone"],
		["Singapore", "Singapore"],
		["Sint Maarten (Dutch part)", "Sint Maarten (Dutch part)"],
		["Slovakia", "Slovakia"],
		["Slovenia", "Slovenia"],
		["Solomon Islands", "Solomon Islands"],
		["Somalia", "Somalia"],
		["South Africa", "South Africa"],
		["South Georgia and the South Sandwich Islands", "South Georgia and the South Sandwich Islands"],
		["South Sudan", "South Sudan"],
		["Spain", "Spain"],
		["Sri Lanka", "Sri Lanka"],
		["Sudan (the)", "Sudan (the)"],
		["Suriname", "Suriname"],
		["Svalbard and Jan Mayen", "Svalbard and Jan Mayen"],
		["Sweden", "Sweden"],
		["Switzerland", "Switzerland"],
		["Syrian Arab Republic", "Syrian Arab Republic"],
		["Taiwan", "Taiwan"],
		["Tajikistan", "Tajikistan"],
		["Tanzania, United Republic of", "Tanzania, United Republic of"],
		["Thailand", "Thailand"],
		["Timor-Leste", "Timor-Leste"],
		["Togo", "Togo"],
		["Tokelau", "Tokelau"],
		["Tonga", "Tonga"],
		["Trinidad and Tobago", "Trinidad and Tobago"],
		["Tunisia", "Tunisia"],
		["Turkey", "Turkey"],
		["Turkmenistan", "Turkmenistan"],
		["Turks and Caicos Islands (the)", "Turks and Caicos Islands (the)"],
		["Tuvalu", "Tuvalu"],
		["Uganda", "Uganda"],
		["Ukraine", "Ukraine"],
		["United Arab Emirates (the)", "United Arab Emirates (the)"],
		["United Kingdom of Great Britain and Northern Ireland (the)", "United Kingdom of Great Britain and Northern Ireland (the)"],
		["United States Minor Outlying Islands (the)", "United States Minor Outlying Islands (the)"],
		["United States of America (the)", "United States of America (the)"],
		["Uruguay", "Uruguay"],
		["Uzbekistan", "Uzbekistan"],
		["Vanuatu", "Vanuatu"],
		["Venezuela (Bolivarian Republic of)", "Venezuela (Bolivarian Republic of)"],
		["Viet Nam", "Viet Nam"],
		["Virgin Islands (British)", "Virgin Islands (British)"],
		["Virgin Islands (U.S.)", "Virgin Islands (U.S.)"],
		["Wallis and Futuna", "Wallis and Futuna"],
		["Western Sahara", "Western Sahara"],
		["Yemen", "Yemen"],
		["Zambia", "Zambia"],
		["Zimbabwe", "Zimbabwe"],
		["Åland Islands", "Åland Islands"]
	]

	def self.clean_answers(answers)
		answers = answers.symbolize_keys
		unless (answers.keys - @@types.keys).empty? and (@@questions.keys - answers.keys).empty?
			return nil
		end
		
		answers.each do |key, value|
			answers[key] = value.strip if value.acts_like? :string
		end
		
		answers[:work] = works[answers[:work].downcase.to_sym] if answers[:work].acts_like? :string
		answers[:budget] = Integer(answers[:budget]) rescue ""
		answers[:longitude] = Float(answers[:longitude]) rescue ""
		answers[:latitude] = Float(answers[:latitude]) rescue ""

		answers.each do |name, value|
			case @@types[name]
				when :string then
					return nil unless (value.is_a? String) && (value.length > 0)
				when :integer then
					return nil unless value.is_a? Integer
				when :float then
					return nil unless value.is_a? Float
			end
		end

		return answers
	end

	def self.infer_zip_code(answers)
		begin
			answers[:zip_code] = Integer(Geocoder.search([answers[:latitude].to_s, answers[:longitude].to_s]).first.postal_code)
		rescue
			return nil
		else
			return answers
		end
	end

	def self.clean_and_complete(answers)
		puts answers
		answers = self.clean_answers answers
		answers = self.infer_zip_code answers unless answers.nil?
		answers
	end

	def self.create_guest(answers)
		answers = self.clean_answers answers
		answers[:name] = "Guest"
		return User.new answers
	end
end
