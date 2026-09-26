class Post < ApplicationRecord
  belongs_to :user

  # data-model-schema.md: 500-char cap
  validates :body, presence: true, length: { maximum: 500 }
end
