require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }

  describe 'POST #create' do
    context 'Authenticated user can add comment' do
      context 'with valid attributes' do
        before { login(user) }

        it 'save drone comment' do
          expect do
            process(:create, method: :post, params: { post_id: post, user_id: user,
                                    comment: attributes_for(:comment) })
          end.to change(Comment, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        before { login(user) }

        it 'do not save drone comment' do
          expect do
            process(:create, method: :post, params: { post_id: post, user_id: user,
                                    comment: attributes_for(:comment, :invalid) })
          end.not_to change(Comment, :count)
        end

        it 'render create' do
          process(:create, method: :post, params: { post_id: post, user_id: user,
                                  comment: attributes_for(:comment, :invalid) })

          expect(response).to render_template :new
        end
      end
    end

    context 'Unauthenticated user can add comment' do
      it 'does not save drone comment' do
        expect do
          process(:create, method: :post, params: { post_id: post, user_id: user,
                                  comment: attributes_for(:comment) })
        end.not_to change(Comment, :count)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:comment) { create(:comment, post: post, user: user) }

    context 'authenticated user' do
      before { login(user) }
      context 'with valid attributes' do
        context "with user's comment" do
          it 'changes comment attributes' do
            patch :update, params: { id: comment.id, post_id: post, user_id: user, comment: { body: 'new body' } }
            comment.reload
            expect(comment.body).to eq 'new body'
          end

          it "is comment user's" do
            patch :update, params: { id: comment.id, post_id: post, user_id: user, comment: { body: 'new body' } }
            expect(assigns(:comment).user).to eq user
          end
        end
      end

      context 'with invalid attributes' do
        it 'does not changes comment attributes' do
          expect do
            patch :update, params: { id: comment.id, post_id: post, user_id: user, comment: attributes_for(:comment, :invalid) }
          end.to_not change(comment, :body)
        end
      end
    end

    context 'unauthenticated user' do
      context 'with valid attributes' do
        it 'does not change attributes' do
          expect do
            patch :update, params: { id: comment.id, post_id: post, user_id: user, comment: { body: 'new body' } }
          end.to_not change(comment, :body)
        end

        it 'redirect to sign in page' do
          patch :update, params: { id: comment.id, post_id: post, user_id: user, comment: { body: 'new body' } }
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'with invalid attributes' do
        it 'does not change attributes' do
          expect do
            patch :update, params: { id: comment.id, post_id: post, user_id: user, comment: attributes_for(:comment, :invalid) }
          end.to_not change(comment, :body)
        end

        it 'redirect to sign in page' do
          patch :update, params: { id: comment.id, post_id: post, user_id: user, comment: attributes_for(:comment, :invalid) }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'authenticated user' do
      before { login(user) }

      context 'comment that the user created' do
        let!(:comment) { create(:comment, post: post, user: user) }

        it 'delete the comment' do
          expect do
            delete :destroy, params: { id: comment.id, post_id: post, user_id: user }
          end.to change(Comment, :count).by(-1)
        end
      end
    end

    context 'unauthenticated user' do
      let!(:comment) { create(:comment, post: post, user: user) }

      it 'unsuccessful attempt to delete someone another comment' do
        expect do
          delete :destroy, params: { id: comment.id, post_id: post, user_id: user }
        end.to_not change(Comment, :count)
      end

      it 'redirect to sign in' do
        delete :destroy, params: { id: comment.id, post_id: post, user_id: user }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
