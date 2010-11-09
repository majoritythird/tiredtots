class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :claim_token, :email, :name, :password, :password_confirmation, :remember_me

  has_many :children, :dependent => :destroy

end
