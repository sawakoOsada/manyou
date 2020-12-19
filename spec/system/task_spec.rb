require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  let!(:user) {FactoryBot.create(:user)}
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:task2) { FactoryBot.create(:task, name: 'name_searched', state: 'start', priority: 'high', user: user) }

  before do
    visit root_path
    fill_in 'メールアドレス', with: 'admined@test.com'
    fill_in 'パスワード', with: 'admined_password'
    click_on 'Log in'
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'task1'
        fill_in 'タスク詳細', with: 'content1'
        find_by_id('task_deadline_1i').select '2020'
        find_by_id('task_deadline_2i').select '12月'
        find_by_id('task_deadline_3i').select '3'
        find_by_id('task_state').select 'start'
        find_by_id('task_priority').select 'high'
        click_on '登録する'
        expect(find('.task_table').text).to have_content 'task1'
        expect(find('.task_table').text).to have_content 'content1'
      end
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'タイトル検索', with: 'searched'
        click_on '検索'
        expect(find('.task_table').text).to have_content 'name_searched'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        find("option[value='1']").select_option
        click_on '検索'
        expect(find('.task_table').text).to have_content 'start'
        expect(find('.task_table').text).not_to have_content 'wait'
        expect(find('.task_table').text).not_to have_content 'done'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'タイトル検索', with: 'searched'
        find("option[value='1']").select_option
        click_on '検索'
        expect(find('.task_table').text).to have_content 'name_searched'
        expect(find('.task_table').text).to have_content 'start'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(find('.task_table').text).to have_content 'test_name'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        new_task = FactoryBot.create(:task, name: 'new_name', content: 'new_content', user: user)
        visit tasks_path
        task_list = all('#task_row')
        expect(task_list[0]).to have_content 'new_name'
      end
    end
    context '終了期限でソートするリンクを押した場合' do
      it '終了期限の早いタスクが一番上に表示される' do
        fast_task = FactoryBot.create(:task, name: 'fast_name', content: 'fast_content', deadline: Time.zone.today - 1, user: user)
        visit tasks_path
        find('.sort_deadline').click
        task_list_desc = all('#task_row')
        expect(task_list_desc[0]).to have_content 'fast_name'
      end
    end
    context '優先順位でソートするリンクを押した場合' do
      it '優先順位の高い順に表示される' do
        low_task = FactoryBot.create(:task, name: 'name_low', content: 'content_low', priority: 'low', user: user)
        visit tasks_path
        find('.sort_priority').click
        task_list_desc = all('#task_row')
        expect(task_list_desc[0]).to have_content 'name_searched'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task.id)
        expect(page).to have_content 'test_name'
        expect(page).to have_content 'test_content'
      end
    end
  end
end
