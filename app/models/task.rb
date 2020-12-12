class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  enum state:{wait: 0, start: 1, done: 2}
  enum priority:{low: 0, middle: 1, high: 2}
  scope :search_name, ->(name) { where(['name LIKE ?', name]) }
  scope :search_state, ->(status) { where(state: status) }
  paginates_per 10
end
