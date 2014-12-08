class WeekReport < ActiveRecord::Base
	# 所属
	belongs_to :user
	belongs_to :project
	# フォームの検証
	validates :user_id, presence: true
	validates :project_id, presence: true
	validates :done, presence: true, length: { maximum: 2000 }
	validates :understood, presence: true, length: { maximum: 2000 }
	validates :next, presence: true, length: { maximum: 2000 }
	validates :start_day, presence: true
end
