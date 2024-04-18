require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_rich_text(:body) }
    it { should have_and_belong_to_many(:tags) }
  end

  describe 'scopes' do
    it 'returns posts in the correct order with most_recent scope' do
      post1 = create(:post, created_at: 1.hour.ago)
      post2 = create(:post, created_at: 2.hours.ago)
      post3 = create(:post, created_at: 3.hours.ago)

      expect(Post.most_recent).to eq([post1, post2, post3])
    end
  end
end
