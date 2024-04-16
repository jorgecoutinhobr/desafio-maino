require 'rails_helper'

RSpec.describe Post, type: :model do

  it "is valid with valid attributes" do
    expect(Post.new(title: "Title", body: "Body")).to be_valid
  end

  it "is not valid without a sign in" do
    post = Post.new(title: nil)
    expect(post).to_not be_valid
  end

  it "is not valid without a body" do
    post = Post.new(body: nil)
    expect(post).to_not be_valid
  end

  it "is not valid without a title and body" do
    post = Post.new(title: nil, body: nil)
    expect(post).to_not be_valid
  end

  it "is not valid with a title longer than 255 characters" do
    post = Post.new(title: "a" * 256)
    expect(post).to_not be_valid
  end

  it "is not valid with a body longer than 1000 characters" do
    post = Post.new(body: "a" * 1001)
    expect(post).to_not be_valid
  end
end
