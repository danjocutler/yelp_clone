require 'rails_helper'

describe 'reviewing' do

  it 'allows users to leave a review using a form' do
    sign_up
    create_restaurant
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  it 'user can only leave one review per restaurant' do
    sign_up
    create_restaurant
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    expect(page).not_to have_content "Review KFC"
  end

  it 'displays an average rating for all reviews' do
    sign_up
    create_restaurant
    leave_review('So so', "3")
    click_link 'Sign out'
    sign_up2
    leave_review('Great', "5")
    expect(page).to have_content("Average rating: ★★★★☆")
  end
end