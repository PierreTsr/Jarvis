# README

Team members:

Parth Jawale pcj2105

Aidai Beishekeeva ab5248 

Emily Rhyu er3067

Pierre Tessier pht2119


Instructions to run:
```
bundle install
bundle exec rails webpacker:install
bundle exec rake db:setup 
bundle exec rake db:migrate 
bundle exec rake db:seed 
bundle exec rails s
```

Instructions to test: 
```
bundle exec rake db:migrate RAILS_ENV=test
bundle exec rake db:seed RAILS_ENV=test
bundle exec rspec 
bundle exec cucumber 
```

Heroku link: 
https://aqueous-lake-64776.herokuapp.com/


Github link: 
https://github.com/PierreTsr/Jarvis/


## Info for project iteration1

Jarvis is a recommendation web-tool for people who are moving from different cities. 

We have 4 pages available for project iteration 1. 

Page 1: Landing page with little info on the website

Page 2: Questions page where the user has to fill out the info about themselves. So far, we have test data for Columbia area. Try putting 10025 or 10027 as a zip code when answering the questions. 

Page 3: Categories page with different businesses 

Page 4: Businesses within given categories and for the given zipcode on Page2. If there are no businesses for the index, the page will be blank. 

## Info for project iteration2

Filtering added for businesses (Page 4)

Page 2 is enhanced by adding Google API that lets you add your address.

Page 5. Sign in page with main functionalities .

Page 6. Sign up page with main functionalities. The account is created when the user answers the questions for Page2 and then goes to the sign up page. Another option is to skip the account creation and visit the website as a guest. 

Page 7. Business detail page with reviews. 

Additional tests to cover the new added featues. 


