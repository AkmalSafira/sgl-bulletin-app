class Comment < ActiveRecord::Base
  belongs_to :article
  validates :comment, presence: true, length: {minimum:0, maximum:500}
  scope :recent, -> {order(created_at: :desc)}
end