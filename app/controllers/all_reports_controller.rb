class AllReportsController < ApplicationController
before_action :signed_in_user

def index
	if signed_in?
		@start_day = Date.today.beginning_of_week
		@end_day = @start_day.end_of_week - 2
		@project = nil
		@user = nil
		@user_group = nil
		save_week_session
		@all_reports = WeekReport.where(start_day: @start_day).order(:user_id)
		judge_monthly
	else
		redirect_to controller:'sessions', action:'new'
	end
end

#週報検索
def search_week_or_month
	load_week_session
	if params[:item][:search_target] == "週報"
		@start_day = Date.strptime(params[:item][:date], "%Y年%m月%d日").beginning_of_week
	else
		@start_day = Date.strptime(params[:item][:date], "%Y年%m月%d日").end_of_month.beginning_of_week
		if (2..8).include?(@start_day.end_of_month.day - @start_day.day) then
		else
			@start_day = @start_day - 1.weeks
		end
	end
	@end_day = @start_day.end_of_week - 2
	save_week_session
	get_report
	judge_monthly
	render 'index'
end

#週報検索
def change_week_or_month
	load_week_session
	@start_day = Date.strptime(params[:start], "%Y-%m-%d").beginning_of_week
	@end_day = @start_day.end_of_week - 2
	save_week_session
	get_report
	judge_monthly
	render 'index'
end

#プロジェクトフィルタ
def filter_project
	load_week_session
	@end_day = @start_day.end_of_week - 2
	@project = params[:item][:project_id]
	save_week_session
	get_report
	judge_monthly
	render 'index'
end

#メンバーフィルタ
def filter_member
	load_week_session
	@end_day = @start_day.end_of_week - 2
	@user = params[:item][:user_id]
	save_week_session
	get_report
	judge_monthly
	render 'index'
end

#グループフィルタ
def filter_group
	load_week_session
	@end_day = @start_day.end_of_week - 2
	@user_group = params[:item][:user_group_id]
	save_week_session
	get_report
	judge_monthly
	render 'index'
end

	def upanel
		@time = Time.now.to_s
		render
	end

private
	def get_report
		@all_reports = WeekReport.where(["start_day = ?", @start_day])
		if @user_group.blank?
			unless @project.blank?
				@all_reports = @all_reports.where(["project_id = ?", @project]).order(:user_id)
			end
			unless @user.blank?
				@all_reports = @all_reports.where(["user_id = ?", @user]).order(:user_id)
			end
		else
			ret = Array.new
			@user_list = User.where(user_group_id: @user_group)
			@user_list.each do |user_list|
				ret = ret + @all_reports.where(["user_id = ?", user_list.id])
			end
			@all_reports = ret
		end
	end

	def judge_monthly
		if (2..8).include?(@start_day.end_of_month.day - @start_day.day) then
			flash.now[:info] = "この週は月報です"
		end
	end
		
		def save_week_session
			session[:start_day] = @start_day
			session[:project] = @project
			session[:user] = @user
			session[:user_group] = @user_group
		end
		
		def load_week_session
			@start_day = Date.strptime(session[:start_day], "%Y-%m-%d").beginning_of_week
			@project = session[:project]
			@user = session[:user_id]
			@user_group = session[:user_group]
		end
		
#ファイル最終行のend
end
