class Task < ApplicationRecord
  belongs_to :user
  validates :task_name, presence: true, length: { maximum: 50 }
  validates :task_detail, presence: true, length: { maximum: 300 }
end

