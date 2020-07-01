class User < ActiveRecord::Base
    include BCrypt
    # has_many :follows
    has_many :fr, foreign_key: :following_id, class_name: 'Follow'
    has_many :followers, through: :fr, source: :follower

    has_many :following_relationships, foreign_key: :user_id, class_name: 'Follow'
    has_many :following, through: :following_relationships, source: :following

    has_many :posts
    has_many :comments, through: :posts
    has_many :hearts
    has_secure_password

    def suggest_friends() 
        User.where('id != ?', self.id).order("RANDOM()").limit(5)
    end

    def homepage_posts() 
        Post.where(:user_id => self.id).order(created_at: :desc)
    end

end