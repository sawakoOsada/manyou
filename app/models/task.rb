class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true, uniqueness: true
  #どちらも同じ値が入っている場合のみバリデーションしたい
end
