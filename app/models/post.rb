class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :body
  has_many :comments, dependent: :destroy

  validates :title, :body, :user, presence: true

  scope :most_recent, -> { order(created_at: :desc) }
end
