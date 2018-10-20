class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum:10, maximum:50}
  validates :description, presence: true, length: {minimum:10, maximum:300}
  
end