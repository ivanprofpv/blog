require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post) { create(:post, user:) }
  let(:posts) { create_list(:post, 3, user: user) }
  let(:valid_params) do
    {
      post: {
        title: 'post title',
        body: 'post body'
      }
    }
  end

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET #user_post" do
    it "populates an array of posts for the current user" do
      sign_in user
      get :user_post
      expect(assigns(:posts)).to match_array(posts)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: post } }

    it 'check if variable in controller matches' do
      expect(assigns(:post)).to eq post
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    context 'Authenticated user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'saves a new post in the database' do
          expect do
            process(:create, method: :post, params: { post: attributes_for(:post) })
          end.to change(Post, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'does not saves new post in database' do
          expect do
            process(:create, method: :post, params: { post: attributes_for(:post, :invalid) })
          end.not_to change(Post, :count)
        end
      end
    end

    context 'Unauthenticated user' do
      it 'does not save a new post in the database' do
        expect do
          process(:create, method: :post, params: { post: attributes_for(:post) })
        end.not_to change(Post, :count)
      end

      it 'redirect to sign in' do
        process(:create, method: :post, params: { post: attributes_for(:post) })
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #edit' do
    context 'Authenticated user' do
      before { login(user) }
      before { get :edit, params: { id: post, user: } }

      it 'check if the data is set to a variable @post' do
        expect(assigns(:post)).to eq post
      end
    end

    context 'Unauthenticated user' do
      before { get :edit, params: { id: post, user: } }

      it 'the post does not change' do
        expect(assigns(:post)).to_not eq post
      end

      it 'redirect to sign in' do
        expect(assigns(:post)).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'Authenticated user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'check if the data is set to a variable @post in controller' do
          patch :update, params: { id: post, post: attributes_for(:post) }
          expect(assigns(:post)).to eq post
        end

        it 'change existing attributes' do
          patch :update, params: { id: post, post: { title: 'New post' } }
          post.reload

          expect(post.title).to eq 'New post'
        end

        it 'redirect to update post' do
          patch :update, params: { id: post, post: attributes_for(:post) }
          expect(response).to redirect_to post
        end
      end

      context 'with invalid attributes' do
        it 'does not update post' do
          patch :update, params: { id: post, post: attributes_for(:post, :invalid) }
          post.reload

          expect(post.title).to eq 'TitlePost'
        end
      end
    end

    context 'Authenticated other user (not author)' do
      before { login(other_user) }

      it 'does not update post' do
        patch :update, params: { id: post, post: { title: 'new title post' } }
        post.reload

        expect(post.title).to eq post.title
      end

      it 'redirect to post (does not update post)' do
        patch :update, params: { id: post, post: attributes_for(:post) }

        expect(response).to redirect_to post
      end
    end

    context 'Unauthenticated user' do
      it 'does not update drone' do
        patch :update, params: { id: post, post: { title: 'new title post' } }
        post.reload

        expect(post.title).to eq post.title
      end

      it 'redirect to sign in' do
        patch :update, params: { id: post, post: attributes_for(:post) }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'Authenticated user' do
      before { login(user) }

      let!(:post) { create(:post, user:) }

      it 'delete post' do
        delete :destroy, params: { id: post }
        expect(response).to redirect_to root_path
      end
    end

    context 'Unauthenticated user' do
      let!(:post) { create(:post, user:) }

      it 'the post has not been deleted' do
        expect { delete :destroy, params: { id: post } }.to_not change(Post, :count)
      end

      it 'redirect to sign in' do
        delete :destroy, params: { id: post }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
