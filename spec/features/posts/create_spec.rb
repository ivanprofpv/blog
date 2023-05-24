require 'rails_helper'

feature 'User can create post' do

  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit new_post_path
    end

    scenario 'create post' do
      fill_in 'Title', with: 'Test name post'
      fill_in 'Body', with: 'Test body post'

      within '.post_content' do
        click_on 'Create post'
      end

      expect(page).to have_content 'Post was successfully created.'
      expect(page).to have_content 'Test name post'
      expect(page).to have_content 'Test body post'
    end

    scenario 'can not create post (error title and body)' do
      fill_in 'Title', with: ''
      fill_in 'Body', with: ''

      within '.post_content' do
        click_on 'Create post'
      end

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Body can't be blank"
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Can not created post' do
      visit new_post_path

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
