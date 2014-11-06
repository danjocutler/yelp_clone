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

def create_restaurant
    visit '/'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
end