require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  let!(:admin) {FactoryBot.create(:admin)}
  let!(:admined) {FactoryBot.create(:user)}

  describe 'ログイン機能' do


    context 'ログインした場合' do
      it 'current_userに値が入る' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'admin@test.com'
        fill_in 'パスワード', with: 'admin_password'
        click_on 'Log in'
        include SessionsHelper
        expect(page).to have_content 'admin_userのページ'
      end
    end
  end
end
