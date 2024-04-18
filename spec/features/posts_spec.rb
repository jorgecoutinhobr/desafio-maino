require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:another_user) { create(:user) }

  context 'Create a post' do
    describe 'when user Login' do

      before do
        login_as(user)
        visit new_post_path
      end

      context "create a post with failure" do
        scenario 'body cant be blank' do
          fill_in 'post[title]', with: 'My first post'

          click_on 'Submit'
          expect(page).to have_content 'Body can\'t be blank'
          expect(page).not_to have_content 'Title can\'t be blank'
        end

        scenario 'title cant be blank', js: true do
          fill_in_rich_text_area 'post[body]', with: 'Work for us!!!'

          click_on 'Submit'
          expect(page).to have_content 'Title can\'t be blank'
          expect(page).not_to have_content 'Body can\'t be blank'
        end

        scenario 'title and body cant be blank' do
          click_on 'Submit'
          expect(page).to have_content "Title can\'t be blank - Body can\'t be blank"
        end
      end

      context "create a post with success", js: true do
        scenario 'create a post' do
          fill_in 'post[title]', with: 'My first post'
          fill_in_rich_text_area 'post[body]', with: 'Work for us!!!'

          click_on 'Submit'
          expect(page).to have_content 'Post created successfully'
        end
      end
    end

    describe 'when user NOT Login' do
      scenario 'not possible to create a post' do
        visit new_post_path
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
      end
    end
  end

  context 'Edit a post' do
    describe 'when the post creator is logged in' do
      before do
        login_as(user)
        visit edit_post_path(post)
      end

      scenario 'update a post', js: true do
        fill_in 'post[title]', with: 'My first post updated'
        fill_in_rich_text_area 'post[body]', with: 'Work for us!!!'

        click_on 'Submit'
        expect(page).to have_content 'Post updated successfully'
      end
    end

    describe 'when diferent user is logged in' do
      before do
        login_as(another_user)
        visit edit_post_path(post)
      end

      scenario 'not possible to edit a post' do
        expect(page).to have_content 'You are not the owner of this post'
      end
    end

    describe 'when user NOT Login' do
      before do
        visit edit_post_path(post)
      end

      scenario 'not possible to edit a post' do
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
      end
    end
  end

  context 'Delete a post' do
    describe 'when the post creator is logged in' do
      before do
        login_as(user)
        visit post_path(post)
      end

      scenario 'delete a post', js: true do
        click_on 'Delete'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'Post deleted successfully'
      end
    end

    describe 'when diferent user is logged in' do
      before do
        login_as(another_user)
        visit post_path(post)
      end

      scenario 'not possible to delete a post' do
        expect(page).not_to have_content 'Delete'
      end
    end
  end

  context 'Create a comment' do
    describe 'when user Login' do
      before do
        login_as(user)
        visit post_path(post)
      end

      scenario 'create a comment', js: true do
        fill_in_rich_text_area 'comment[body]', with: 'User post!!!'

        click_on 'Add Comment'
        expect(page).to have_content 'User post!!!'
        expect(page).to have_content user.email
        expect(Comment.count).to eq(1)
      end
    end

    describe 'when user NOT Login' do
      before do
        visit post_path(post)
      end

      scenario 'create a comment', js: true do
        fill_in_rich_text_area 'comment[body]', with: 'Anonymous post!!!'

        click_on 'Add Comment'
        expect(page).to have_content 'Anonymous post!!!'
        expect(Comment.count).to eq(1)
      end
    end
  end
end
