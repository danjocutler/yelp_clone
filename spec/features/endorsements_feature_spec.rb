require 'rails_helper'

describe 'endorsing reviews' do
	before do
		kfc = Restaurant.create(name: 'KFC', image: 'missing.png')
		kfc.reviews.create(rating:3, thoughts: "delicious and revolting in equal parts")
	end
end