class Secret < ActiveRecord::Base
  validates :content, presence: :true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users_liked, through: :likes, source: :user
end
