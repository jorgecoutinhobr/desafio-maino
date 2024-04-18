require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
  end

  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user).optional }
    it { should have_rich_text(:body) }
  end
end
