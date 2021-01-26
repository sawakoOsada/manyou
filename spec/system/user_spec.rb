require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  let!(:admin) {FactoryBot.create(:admin)}
  let!(:user) {FactoryBot.create(:user)}

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
        visit tasks_path
        expect(page).to have_content 'ログインしてください'
      end
    end
  end

  describe 'セッション機能' do
    context 'ユーザーが登録されている場合' do
      it 'ログインができる' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'user@test.com'
        fill_in 'パスワード', with: 'user_password'
        click_on 'Log in'
        expect(page).to have_content 'common_userのページ'
      end
    end

    context 'ログインしている場合' do
      before do
        visit new_session_path
        fill_in 'メールアドレス', with: 'user@test.com'
        fill_in 'パスワード', with: 'user_password'
        click_on 'Log in'
      end
      it '自分の詳細画面に飛べる' do
        visit user_path(user.id)
        expect(page).to have_content 'common_userのページ'
      end
      it '他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        visit user_path(admin.id)
        expect(page).to have_content 'タスク一覧'
      end
      it 'ログアウトができる' do
        find('.logout_icon').click
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理機能' do

    context '一般ユーザーの場合' do
      it '管理画面へアクセスするとタスク一覧ページへ飛ぶ' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'user@test.com'
        fill_in 'パスワード', with: 'user_password'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content 'タスク一覧'
      end
    end

    context '管理ユーザーの場合' do

      before do
        visit new_session_path
        fill_in 'メールアドレス', with: 'admin@test.com'
        fill_in 'パスワード', with: 'admin_password'
        click_on 'Log in'
      end

      it '管理画面にアクセスできる' do
        visit admin_users_path
        expect(page).to have_content 'ユーザー一覧'
      end
      it 'ユーザーの新規登録ができる' do
        visit new_admin_user_path
        fill_in 'ユーザー名', with: 'test_user'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'test_password'
        fill_in 'パスワードの確認', with: 'test_password'
        click_on 'Create account'
        expect(page).to have_content 'ユーザーを作成しました'
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        visit admin_user_path(user.id)
        expect(page).to have_content 'common_userのページ'
      end
      it 'ユーザーの編集画面からユーザーを編集できる' do
        visit edit_admin_user_path(user.id)
        fill_in 'ユーザー名', with: 'edited_user'
        fill_in 'メールアドレス', with: 'edited@example.com'
        choose '管理者'
        click_on '変更する'
        expect(page).to have_content 'ユーザーを編集しました'
      end
      it 'ユーザーの削除ができる' do
        visit admin_users_path
        first(".delete_button").click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ユーザーを削除しました'
      end
    end
  end
end
