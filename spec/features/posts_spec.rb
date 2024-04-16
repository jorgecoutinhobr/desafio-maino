require 'rails_helper'

RSpec.feature "Posts", type: :feature do

  describe 'Log in' do
    let(:user) { create(:user) }

    before do
      login_as(user)
    end

    context "create a post with error" do

      scenario 'body cant be blank' do
        visit new_post_path
        fill_in 'Title', with: 'My first post'

        click_on 'Create Post'
        expect(page).to have_content 'Body can\'t be blank'
        expect(page).not_to have_content 'Title can\'t be blank'
      end

      scenario 'title cant be blank' do
        visit new_post_path
        find('trix-editor').click.set('New text')

        click_on 'Create Post'
        expect(page).to have_content 'Title can\'t be blank'
        expect(page).not_to have_content 'Body can\'t be blank'
      end

      scenario 'title and body cant be blank' do
        visit new_post_path

        click_on 'Create Post'
        expect(page).to have_content 'Title can\'t be blank - Body can\'t be blank'
      end
    end
  end




  describe 'without log in' do
    scenario 'create a post' do
      visit new_post_path

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
