class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :firstname, :lastname , presence: true

  #validates :password, format: {
  #  with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!\"?\$%^&.])\S{8,}\z/
  #}
  
end
