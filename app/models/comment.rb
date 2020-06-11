class Comment < ActiveRecord::Base
    belongs_to :post, foreign_key: :post_id, class_name: 'Post'
    belongs_to :user, class_name: 'User'
end

# Make sure a user can make a post V
# make sure the user can comment on his own post  V

# make sure another user can comment on his post V

# Make sure post can gather all comments V

# check to see if you can access all posts 
