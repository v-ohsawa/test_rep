class UserGroupsController < ApplicationController
	before_action :signed_in_user
	before_action :set_user_group, only: [:show, :edit, :update, :destroy]
	def index
		@user_groups = UserGroup.all
	end
	def new
		@user_group = UserGroup.new
	end
	def edit
	end
	def create
		@user_group = user_group.new(user_group_params)
		if @user_group.save
			flash[:success] = "新しい項目が追加されました！"
		else
			flash[:error] = "入力値が不正です！"
		end
		redirect_to controller:'user_groups', action:'index'
	end
	def update
		if @user_group.update(user_group_params)
			flash[:success] = "正しく更新されました！"
		else
			flash[:error] = "入力値が不正です！"
		end
		redirect_to controller:'user_groups', action:'index'
	end
	def destroy
		@user_group.destroy
		flash[:success] = "正しく削除されました！"
		redirect_to controller:'user_groups', action:'index'
	end
	private
	def set_user_group
		@user_group = UserGroup.find(params[:id])
	end
	def user_group_params
		params.require(:user_group).permit(:code, :name)
	end
end
