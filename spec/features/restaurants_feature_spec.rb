require 'rails_helper'

describe 'restaurants' do

	context 'no restaurants have been added' do
		it 'should display a prompt to add a restaurant' do
			visit '/restaurants'
			expect(page).to have_content 'No restaurants'
			expect(page).to have_link 'Add a restaurant'
		end
	end

	context 'restaurants have been added' do

		before do
			Restaurant.create(name: 'KFC')
		end

		it 'should display restaurants' do
		visit '/restaurants'
		expect(page).to have_content('KFC')
		expect(page).not_to have_content('No restaurants yet')
		end
	end
end

describe 'CRUD' do

	context 'creating restaurants' do

		it 'prompts user to fill out a form, then displays the new restaurant' do
			sign_up
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq '/restaurants'
		end
	end

	context 'an invalid restaurant' do

		it "doesn't let you submit a name that is too short" do
			sign_up
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'kf'
			click_button 'Create Restaurant'
			expect(page).not_to have_css 'h2', text: 'kf'
			expect(page).to have_content 'error'
		end

		it "is not valid unless it has a unique name" do
		  Restaurant.create(name: "Moe's Tavern")
		  restaurant = Restaurant.new(name: "Moe's Tavern")
		  expect(restaurant).to have(1).error_on(:name)
		end
	end

	context 'viewing restaurants' do

		it 'lets a user view a restaurant' do
			Restaurant.create(name: 'KFC', id: 1)
			visit '/restaurants'
			click_link 'KFC'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq "/restaurants/#{@kfc.id}"
		end
	end

	context 'editing restaurants' do

	  it 'lets a user edit a restaurant' do
			sign_up
		  create_restaurant
		  click_link 'Edit KFC'
		  fill_in 'Name', with: 'Kentucky Fried Chicken'
		  click_button 'Update Restaurant'
		  expect(page).to have_content 'Kentucky Fried Chicken'
		  expect(current_path).to eq '/restaurants'
	  end

	  it "shouldn't let a user edit a restaurant they haven't created" do
	  	Restaurant.create(name: "KFC")
	  	visit '/'
	  	sign_up(email = 'Dan@test.com',
	  					usernsame = 'Danny',
	  					password = 'password',
	  					password_confirmation = 'password')
	  	expect(page).not_to have_content 'Edit KFC'
	  end
	end

	context 'deleting restaurants' do

	  it "removes a restaurant when a user clicks a delete link" do
	  	sign_up
	  	create_restaurant
	    visit '/restaurants'
	    click_link 'Delete KFC'
	    expect(page).not_to have_content 'KFC'
	    expect(page).to have_content 'Restaurant deleted successfully'
	  end

	  it "only the user who created the restaurant can delete the restaurant" do
	  	visit '/restaurants'
	  	sign_up(email = 'Dan@test.com',
	  					usernsame = 'Danny',
	  					password = 'password',
	  					password_confirmation = 'password')
	  	expect(page).not_to have_content 'Delete KFC'
		end
	end

	describe '#average_rating' do
	  context 'no reviews' do
	    it 'returns "N/A" when there are no reviews' do
	      restaurant = Restaurant.create(name: "The Ivy")
	      expect(restaurant.average_rating).to eq 'N/A'
	    end
	  end
	end	
end