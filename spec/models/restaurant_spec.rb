require 'spec_helper'

RSpec.describe Restaurant, type: :model do
	it 'is not valid with a name of less than three characters' do
		restaurant = Restaurant.new(name: 'kf')
		expect(restaurant).to have(1).error_on(:name)
		expect(restaurant).not_to be_valid
	end

	context 'multiple reviews' do
	  it 'returns the average' do
	    restaurant = Restaurant.create(name: "The Ivy")
	    restaurant.reviews.create(rating: 1)
	    restaurant.reviews.create(rating: 5)
	    expect(restaurant.average_rating).to eq 3
	  end
	end
end