class User < ActiveRecord::Base
	has_many :weibos
	validates :name, presence:true
	validates :email, presence:true
end
