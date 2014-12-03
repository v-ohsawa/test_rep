class ProjectsController < ApplicationController
	before_action :set_project, only: [:edit, :update, :destroy]
	def index
		@projects = Project.all
	end
	def new
		@project = Project.new
	end
	def edit
	end
	def create
		@project = Project.new(project_params)
		if @project.save
			flash[:success] = "新しい項目が追加されました！"
		else
			flash[:danger] = "入力値が不正です！"
		end
		redirect_to controller:'projects', action:'index'
	end
	def update
		if @project.update(project_params)
			flash[:success] = "正しく更新されました！"
		else
			flash[:danger] = "入力値が不正です！"
		end
		redirect_to controller:'projects', action:'index'
	end
	def destroy
		@project.destroy
		flash[:success] = "正しく削除されました！"
		redirect_to controller:'projects', action:'index'
	end
	private
	def set_project
		@project = Project.find(params[:id])
	end
	def project_params
		params.require(:project).permit(:code, :name)
	end
end
