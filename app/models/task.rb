class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true, uniqueness: true
end
