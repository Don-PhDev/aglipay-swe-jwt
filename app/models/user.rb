class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         :validatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :orders

  validates :email, presence: true, uniqueness: true

  alias_attribute :name, :email
end
