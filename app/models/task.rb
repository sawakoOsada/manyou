class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  #どちらも同じ値が入っている場合のみバリデーションしたい
  enum state:{wait: 0, start: 1, done: 2}

  scope :search_name, ->(name) { where(['name LIKE ?', name]) }
  scope :search_state, ->(status) { where(state: status) }

end
