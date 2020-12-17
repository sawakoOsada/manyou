require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  let!(:user) {FactoryBot.create(:user, email: 'aaaa@aaaa.com', password: 'aaaaaa')}

  describe '新規登録機能' do
    context 'ユーザーを新規登録した場合' do
      it 'ユーザーのプロフィールが表示される' do
        visit new_user_path
        fill_in 'ユーザー名', with: 'new_user'
        fill_in 'メールアドレス', with: 'new@example.com'
        fill_in 'パスワード', with: 'new_password'
        fill_in 'パスワードの確認', with: 'new_password'
        click_on 'Sign up'
        expect(page).to have_content 'new_userのページ'
      end
    end
    context '未ログイン状態でタスク一覧画面へ飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        get tasks_url
        expect(page).to redirect_to( new_session_url )
      end
    end
  end

  describe 'セッション機能' do
    context 'ユーザーが登録されている場合' do
      it 'ログインができる' do
        signed_user = FactoryBot.create(:user, name: 'signed_user', email: 'sign@aaaa.com', password: 'aaaaaa')
        visit new_session_path
        fill_in 'メールアドレス', with: 'sign@aaaa.com'
        fill_in 'パスワード', with: 'aaaaaa'
        click_on 'Log in'
        expect(page).to have_content 'signed_userのページ'
      end
    end
    context 'ログインしている場合' do
      before do
        visit root_path
        fill_in 'メールアドレス', with: 'aaaa@aaaa.com'
        fill_in 'パスワード', with: 'aaaaaa'
        click_on 'Log in'
      end
      it '自分の詳細画面に飛べる' do
        visit user_path(user.id)
        expect(page).to have_content 'test_userのページ'
      end
      it '他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        another_user = FactoryBot.create(:user, name: 'another_user', email: 'another@aaaa.com', password: 'aaaaaa')
        get user_url(another_user.id)
        expect(page).to redirect_to(tasks_url)
      end
      it 'ログアウトができる' do
        find('.logout_icon').click
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
end
