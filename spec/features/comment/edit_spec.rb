require 'rails_helper'

feature 'User can delete component in drone-card' do
  given(:user) { create(:user) }
  given!(:post) { create(:post, user: user) }
  given!(:comment) { create(:comment, post: post, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit post_path(post)
    end

    scenario 'edit comment if author' do
      click_on 'Edit comment'
      save_and_open_page
      fill_in(id: 'floatingTextarea', with: 'new name comment')

      click_on 'Update comment'

      expect(page).to have_content('new name comment')
    end

    scenario 'do not save (errors)' do

      click_on 'Edit comment'

      fill_in(id: 'floatingTextarea', with: '')

      click_on 'Update comment'

      expect(page).to have_content("Body can't be blank")
    end
  end

  describe 'Unauthenticated user' do
    background do
      visit post_path(post)
    end

    scenario 'can not see edit button' do

      within ".comments" do
        expect(page).to_not have_content 'Edit'
      end
    end
  end
end
