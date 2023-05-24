require 'rails_helper'

feature 'user can see a list of all posts' do
  given(:user) { create(:user) }
  given!(:post) { create_list(:post, 2, user: user) }

  scenario 'authenticated user can see a list of all posts' do
    sign_in(user)
    visit root_path

    expect(page).to have_content post[0].title
    expect(page).to have_content post[1].title
  end

  scenario 'unauthenticated user can see a list of all posts' do
    visit root_path

    expect(page).to have_content post[0].title
    expect(page).to have_content post[1].title
  end
end
