def sign_up(email = 'test@test.com',
            username = 'tester',
            password = 'password',
            password_confirmation = 'password')
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    fill_in('Password confirmation', with: password_confirmation)
    click_button('Sign up')
end

def sign_up2(email = 'tester@test.com',
            username = 'test',
            password = 'password',
            password_confirmation = 'password')
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    fill_in('Password confirmation', with: password_confirmation)
    click_button('Sign up')
end

def create_restaurant
    visit '/'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
end


def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in "Thoughts", with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end