require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }
  let(:posts) { create_list(:post, 3, user: user) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it 'Authenticated user have one attached foto to post' do
    expect(Post.new.attachment).to be_an_instance_of(ActiveStorage::Attached::One)
  end

  it 'validate foto for post' do
    attachment = build(:post, attachment: Rack::Test::UploadedFile.new("#{Rails.root}/public/apple-touch-icon.png",
                                                                       'image/png'))
    expect(post).to be_valid
  end

  describe "method user_posts" do
    it "returns posts for a given user" do
      expect(Post.user_posts(user)).to match_array(posts)
    end
  end
end
