class Group < ActiveRecord::Base
	#所有
	## グループはユーザーを所有する
	has_many :users, :foreign_key => 'group_id'
	has_many :week_reports, through: :users
end
