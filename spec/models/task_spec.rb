require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  let(:user) { FactoryBot.create(:user) }
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '', content: '失敗テスト', user: user)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗テスト', content: '', user: user)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '成功テスト', content: '成功テスト', user: user)
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, name: 'task1', user: user) }
    let!(:second_task) { FactoryBot.create(:task, name: 'searched', state: 'start', user: user) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_name('searched')).to include(second_task)
        expect(Task.search_name('searched')).not_to include(task)
        expect(Task.search_name('searched').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_state('start')).to include(second_task)
        expect(Task.search_state('start')).not_to include(task)
        expect(Task.search_state('start').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_name('searched').search_state('start')).to include(second_task)
        expect(Task.search_name('searched').search_state('start')).not_to include(task)
        expect(Task.search_name('searched').search_state('start').count).to eq 1
      end
    end
  end

end
