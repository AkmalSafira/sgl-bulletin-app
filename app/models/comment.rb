class Comment < ActiveRecord::Base
belongs_to :article 
validates :content, presence: true
scope :recent, -> {order(created_at: :desc)}

end
