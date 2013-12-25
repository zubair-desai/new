class User < ActiveRecord::Base

	#attr_protected :admin
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password

	has_many :microposts, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower

	before_save { self.email = email.downcase }
	before_create :create_remember_token
	
	
	validates :name, presence: true, length: { maximum: 50 }
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  	validates :password, length: { minimum: 6 }



  	def following?(other_user)
  		self.relationships.find_by_followed_id(other_user.id)  
  	end


	def follow!(other_user)
		self.relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		self.relationships.find_by_followed_id(other_user.id).destroy
	end


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
