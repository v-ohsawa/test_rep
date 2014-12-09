class Project < ActiveRecord::Base
	# 所有
	has_many :week_reports
	# メソッド
	## コード+プロジェクト名を生成
	def project_id_and_name
		self.code.to_s + ' : ' + self.name
	end
end
