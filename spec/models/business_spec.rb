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
    expect(Business.businesses_with_ratings_prices('groceries', [1.0, 2.0, 3.0, 4.0], ["$", "$$","$$$", "$$$$"], {:top => [40.7, -74], :bottom => [40.81, -73.8]}).any? { |business| business['name'] == 'H Mart' }).to be_truthy
    expect(Business.businesses_with_ratings_prices('groceries', [1.0, 2.0, 3.0, 4.0], ["$", "$$","$$$", "$$$$"], {:top => [40.7, -74], :bottom => [40.81, -73.8]}).any? { |business| business['name'] == 'Citibank' }).to be_falsy
  end

  it "should filter by price" do
    expect(Business.businesses_with_ratings_prices('hardware', [1.0, 2.0, 3.0, 4.0], ["$"], {:top => [40.7, -74], :bottom => [40.81, -73.8]}).any? { |business| business['name'] == 'Garcia Hardware' }).to be_truthy
    expect(Business.businesses_with_ratings_prices('hardware', [1.0, 2.0, 3.0, 4.0], ["$"], {:top => [40.7, -74], :bottom => [40.81, -73.8]}).any? { |business| business['name'] == 'Nanz Custom Hardware' }).to be_falsy
  end

  it "should filter by rating" do
    expect(Business.businesses_with_ratings_prices('hardware', [3.0], ['$', '$$', '$$$', '$$$$'], {:top => [40.7, -74], :bottom => [40.81, -73.8]}).any? { |business| business['name'] == 'United Hardware' }).to be_truthy
    expect(Business.businesses_with_ratings_prices('hardware', [3.0], ['$', '$$', '$$$', '$$$$'], {:top => [40.7, -74], :bottom => [40.81, -73.8]}).any? { |business| business['name'] == 'Garcia Hardware' }).to be_falsy
  end

  it "should filter by both ratings and prices" do
    expect(Business.businesses_with_ratings_prices('groceries', [2.0, 4.0], ['$'], {:top => [40.7, -74], :bottom => [40.81, -73.8]}).any? { |business| business['name'] == 'ALDI' }).to be_truthy
    expect(Business.businesses_with_ratings_prices('groceries', [2.0], ['$'], {:top => [40.7, -74], :bottom => [40.81, -73.8]}).any? { |business| business['name'] == 'Hamilton Deli' }).to be_falsy
  end

  

end
