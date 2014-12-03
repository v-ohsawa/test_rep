class Group < ActiveRecord::Base
	#所有
	## グループはユーザーを所有する
	has_many :users
end
