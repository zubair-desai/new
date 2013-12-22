class User < ActiveRecord::Base

	#attr_protected :admin
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password

	has_many :microposts, dependent: :destroy

	before_save { self.email = email.downcase }
	before_create :create_remember_token
	
	
	validates :name, presence: true, length: { maximum: 50 }
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  	validates :password, length: { minimum: 6 }


	def feed
		#This is only a proto feed.
		microposts #self.microposts is not needed because we're not doing an assignment
		
	end

# =>  does not belong here?
  def User.new_remember_token   # =>  similar to self.function -  http://chat.stackexchange.com/rooms/11932/discussion-between-tim-and-mrk-fldig
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
	    def create_remember_token
	      self.remember_token = User.encrypt(User.new_remember_token)
	    end    
end
