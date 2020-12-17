require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  let!(:admin) {FactoryBot.create(:admin, email: 'admin@aaaa.com', password: 'aaaaaa')}
  let!(:admined) {FactoryBot.create(:user, name: 'admined', email: 'admined@aaaa.com', password: 'aaaaaa')}

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
        visit new_session_path
        fill_in 'メールアドレス', with: 'admined@aaaa.com'
        fill_in 'パスワード', with: 'aaaaaa'
        click_on 'Log in'
        expect(page).to have_content 'adminedのページ'
      end
    end

    context 'ログインしている場合' do
      before do
        visit root_path
        fill_in 'メールアドレス', with: 'admined@aaaa.com'
        fill_in 'パスワード', with: 'aaaaaa'
        click_on 'Log in'
      end
      it '自分の詳細画面に飛べる' do
        visit user_path(admined.id)
        expect(page).to have_content 'adminedのページ'
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

  describe '管理機能' do

    context '一般ユーザーの場合' do
      it '管理画面へアクセスするとタスク一覧ページへ飛ぶ' do
        visit root_path
        fill_in 'メールアドレス', with: 'admined@aaaa.com'
        fill_in 'パスワード', with: 'aaaaaa'
        click_on 'Log in'
        get admin_users_url
        expect(page).to redirect_to( tasks_url )
      end
    end

    context '管理ユーザーの場合' do

      before do
        visit root_path
        fill_in 'メールアドレス', with: 'admin@aaaa.com'
        fill_in 'パスワード', with: 'aaaaaa'
        click_on 'Log in'
      end

      it '管理画面にアクセスできる' do
        binding.pry
        get admin_users_url
        expect(page).to redirect_to(admin_users_url)
      end
      it 'ユーザーの新規登録ができる' do
        visit new_admin_user_path
        fill_in '名前', with: 'test_user'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'test_password'
        fill_in 'パスワードの確認', with: 'test_password'
        click_on 'Create account'
        expect(page).to have_content 'ユーザーを作成しました'
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        get admin_users_url(admined.id)
        expect(page).to redirect_to(admin_users_url(admined.id))
      end
      it 'ユーザーの編集画面からユーザーを編集できる' do
        visit edit_admin_user_path(admined.id)
        fill_in '名前', with: 'edited_user'
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
