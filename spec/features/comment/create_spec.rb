require 'rails_helper'

feature 'User can add comment for post' do
  given(:user) { create(:user) }
  given!(:post) { create(:post, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit post_path(post)
    end

    scenario 'add comment to post' do
      within ".comments" do
        fill_in(id: 'floatingTextarea', with: 'test comment')
      end
      click_on 'Create comment'

      expect(page).to have_content('test comment')
    end

    scenario 'add comment with error' do
      click_on 'Create comment'

      expect(page).to have_content("Body can't be blank")
    end
  end

  describe 'Unauthenticated user' do
    scenario 'do not add comment' do
      visit post_path(post)

      expect(page).not_to have_content('Create comment')
    end
  end
end
