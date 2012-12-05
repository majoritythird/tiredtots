class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  attr_accessible :claim_token, :email, :name, :password, :password_confirmation, :remember_me, :time_zone

  has_many :children, :dependent => :destroy

end
