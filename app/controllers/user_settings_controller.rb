class UserSettingsController < ApplicationController
	before_action :signed_in_user
	before_action :correct_user,   only: [:edit, :update]

	def edit
	end

	def update
		if @user_setting.update(user_params)
			flash[:success] = "パスワードが正しく更新されました！"
		else
			flash[:danger] = "パスワードが一致しません！"
		end
		redirect_to controller:'week_reports', action:'index'
	end

	private

	#ストロングパラメータの記述
	def user_params
		params.require(:user).permit(:name, :worker_id, :password, :password_confirmation)
	end

	# Before actions
	def correct_user
		@user_setting = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user_setting)
	end

	def admin_user
		redirect_to(root_path) unless current_user.admin?
	end
end