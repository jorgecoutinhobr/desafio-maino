class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :body
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :title, :body, :user, presence: true

  scope :most_recent, -> { order(created_at: :desc) }
end
