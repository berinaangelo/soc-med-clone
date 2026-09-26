class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Profile fields (data-model-schema.md, profile-editing.md) — name required, bio and
  # profile_picture (a pasted URL, no Active Storage for MVP per mvp-scope.md cut #3) optional.
  validates :name, presence: true
end
