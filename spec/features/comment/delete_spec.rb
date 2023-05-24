require 'rails_helper'

feature 'User can delete component in drone-card' do
  given(:user) { create(:user) }
  given(:post) { create(:post, user: user) }
  given!(:comment) { create(:comment, post: post, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit post_path(post)
    end

    scenario 'delete button' do

      within ".comments" do
        expect(page).to have_content 'Delete comment'
      end
    end
  end

  describe 'Unauthenticated user' do
    background do
      visit post_path(post)
    end

    scenario 'can not see delete button' do

      within ".comments" do
        expect(page).to_not have_content 'Delete comment'
      end
    end
  end
end
