class User < ApplicationRecord
  before_destroy :not_destroy_last_admin
  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :new
  has_many :tasks, dependent: :destroy

  private
  def not_destroy_last_admin
    if User.where(admin: true).count <= 1
      throw(:abort)
    end
  end
end
