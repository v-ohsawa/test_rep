class GroupsController < ApplicationController
	before_action :set_group, only: [:show, :edit, :update, :destroy]
	def index
		@groups = Group.all
	end
	def new
		@group = Group.new
	end
	def edit
	end
	def create
		@group = Group.new(group_params)
		if @group.save
			flash[:success] = "新しい項目が追加されました！"
		else
			flash[:error] = "入力値が不正です！"
		end
		redirect_to controller:'groups', action:'index'
	end
	def update
		if @group.update(group_params)
			flash[:success] = "正しく更新されました！"
		else
			flash[:error] = "入力値が不正です！"
		end
		redirect_to controller:'groups', action:'index'
	end
	def destroy
		@group.destroy
		flash[:success] = "正しく削除されました！"
		redirect_to controller:'groups', action:'index'
	end
	private
	def set_group
		@group = Group.find(params[:id])
	end
	def group_params
		params.require(:group).permit(:code, :name)
	end
end
