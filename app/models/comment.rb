class Comment < ActiveRecord::Base
    belongs_to :post, foreign_key: :post_id, class_name: 'Post'
    belongs_to :user, class_name: 'User'
end

