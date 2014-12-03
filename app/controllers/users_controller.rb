class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :destroy]
	def index
		@users = User.all
	end
	def new
		@user = User.new
	end
	def edit
	end
	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "新しい項目が追加されました！"
		else
			flash[:danger] = "入力値が不正です！"
		end
		redirect_to controller:'users', action:'index'
	end
	def update
		if @user.update(user_params)
			flash[:success] = "正しく更新されました！"
		else
			flash[:danger] = "入力値が不正です！"
		end
		redirect_to controller:'users', action:'index'
	end
	def destroy
		@user.destroy
		flash[:success] = "正しく削除されました！"
		redirect_to controller:'users', action:'index'
	end
	private
	def set_user
		@user = User.find(params[:id])
	end
	def user_params
		params.require(:user).permit(:name, :worker_num, :group_id, :password, :password_confirmation)
	end
end
