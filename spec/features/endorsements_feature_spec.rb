require 'rails_helper'

describe 'endorsing reviews' do
	before do
		kfc = Restaurant.create(name: 'KFC', image: 'missing.png')
		kfc.reviews.create(rating:3, thoughts: "delicious and revolting in equal parts")
	end

	it 'a user can endorse a review, which updates the review endorsement count', js: true do
		visit '/restaurants'
		click_link 'Endorse'
		expect(page).to have_content('1 endorsement')
	end
end