# frozen_string_literal: true

# model for user
class User < ApplicationRecord
  PASSWORD_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!"?$%^&.])\S{8,}\z/.freeze # rubocop:disable Layout/LineLength

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable



  validates :firstname, :lastname, presence: true
  validates :password, format: {
    with: PASSWORD_FORMAT
  }

  def password_required?
    false
  end
end
