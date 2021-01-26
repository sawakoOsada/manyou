class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy, foreign_key: 'task_id'
  has_many :tasks, through: :labellings
end
