class User < ActiveRecord::Base
	attr_accessor :password
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/

	validates :name, presence: true, length: {within: 5..20}
	#validates :email, presence: true, format: {with: email_regex}, uniqueness: {case_sensitive: false}
	validates :password, :confirmation => true

	validates :password, :presence => true, :confirmation => true, :length => { :within => 6..40 }

	before_save :encrypt_password

	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end

	def self.authenticate(email, password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password? password
	end

	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		return nil if user.nil?
		return user if user.salt == cookie_salt
	end

	private

		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end

		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end

		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
