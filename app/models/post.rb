class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :attachment, dependent: :destroy

  validates :title, :body, presence: true

  validates :attachment, content_type: { in: ['image/png', 'image/jpeg', 'image/jpg'], message: 'must be a JPEG, PNG or JPG' },
                              size: { less_than: 5.megabytes, message: 'image is too large, max size 1 image - 5MB' }
end
