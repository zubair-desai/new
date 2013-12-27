class Micropost < ActiveRecord::Base

	attr_accessible :content
	belongs_to :user

	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 140 }


	default_scope -> { order(created_at: :desc) } #refactored from 'created_at DESC'

	def self.from_users_followed_by(user)
		#followed_users comes from User.rb association, alias of followed column in relationship table
		# => Below is a "sub select" or a select within a select
		# => We pull a Microfeed table of followers that are followers of the user, and also a table of the user 

		followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"  #setting local variable

		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
	end


end
