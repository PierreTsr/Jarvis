require 'simplecov'
SimpleCov.start

require 'rails_helper'

RSpec.describe Business, type: :model do
  it "should return all categories" do
    # allow(Business.new).to receive(:get_all_categories).and_return(['grocery', 'restaurants', 'banks', 'hardware'])
    # puts(Business.new.get_all_categories())
    expect(Business.new.get_all_categories().length()).to eq(4)
    expect(Business.new.get_all_categories()).to contain_exactly('groceries', 'restaurants', 'banks', 'hardware')
  end
  
  it "should return businesses from the category" do
    # allow(Business.new).to receive(:get_business_from_category).with('grocery').and_return([{:name => 'Westside Market'}])
    expect(Business.new.get_business_from_category('groceries', 10025).any? { |business| business['name'] == 'Westside Market' }).to be_truthy
    expect(Business.new.get_business_from_category('groceries', 10025).any? { |business| business['name'] == 'Citibank' }).to be_falsy
  end

  it "should filter by price" do
    expect(Business.new.get_business_from_category('hardware', 10025).with_prices("$").any? { |business| business['name'] == 'Garcia Hardware' }).to be_truthy
    expect(Business.new.get_business_from_category('hardware', 10025).with_prices("$").any? { |business| business['name'] == 'Nanz Custom Hardware' }).to be_falsy
  end

  it "should filter by rating" do
    expect(Business.new.get_business_from_category('hardware', 10025).with_ratings("hardware",[3.0]).any? { |business| business['name'] == 'United Hardware' }).to be_truthy
    expect(Business.new.get_business_from_category('hardware', 10025).with_ratings("hardware",[3.0]).any? { |business| business['name'] == 'Garcia Hardware' }).to be_falsy
  end

end
