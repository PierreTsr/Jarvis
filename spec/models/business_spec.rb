require 'simplecov'
SimpleCov.start

require 'rails_helper'

RSpec.describe Business, type: :model do
  it "should return all categories" do
    # allow(Business.new).to receive(:get_all_categories).and_return(['grocery', 'restaurants', 'banks', 'hardware'])
    # puts(Business.new.get_all_categories())
    expect(Business.new.get_all_categories().length()).to eq(4)
    expect(Business.new.get_all_categories()).to contain_exactly('grocery', 'restaurants', 'banks', 'hardware')
  end
  
  it "should return businesses from the category" do
    # allow(Business.new).to receive(:get_business_from_category).with('grocery').and_return([{:name => 'Westside Market'}])
    expect(Business.new.get_business_from_category('grocery').any? { |business| business['name'] == 'Westside Market' }).to be_truthy
    expect(Business.new.get_business_from_category('grocery').any? { |business| business['name'] == 'Citibank' }).to be_falsy
  end
end
