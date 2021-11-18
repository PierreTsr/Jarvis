Then /^I should be at the business page for: "([^\"]*)"$/ do |business_name|

    business = Business.find_by_name(business_name)
    puts URI.parse(current_url).path == "/business/#{business.id}"
    "/business/#{business.id}".should == URI.parse(current_url).path
  end