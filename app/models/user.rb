class User < ActiveRecord::Base
	attr_accessor :password
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/

	validates :name, presence: true, length: {within: 5..20}
	#validates :email, presence: true, format: {with: email_regex}, uniqueness: {case_sensitive: false}
	validates :password, presence: true, length: {within: 6..15}

	def has_password?(submitted_password)
		self.encrypted_password == encrypt(submitted_password)
	end

	def self.authenticate(email, password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password? password
	end

	def encrypt(password)
		Digest::SHA2.hexdigest password
	end
end
