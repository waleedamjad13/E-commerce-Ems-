# frozen_string_literal: true

# model for user
class User < ApplicationRecord
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  extend QueryMethods

  PASSWORD_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!"?$%^&.])\S{8,}\z/.freeze # rubocop:disable Layout/LineLength

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  #
  # validations
  #
  validates :firstname, :lastname, presence: true
  validates :password, format: { with: PASSWORD_FORMAT }
end
