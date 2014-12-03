class AllReportsController < ApplicationController

def index
	if signed_in?
		@start_day = Date.today.beginning_of_week
		@end_day = @start_day.end_of_week - 2
		@all_reports = WeekReport.where(start_day: @start_day)
		session[:start_day] = @start_day
		judge_monthly
	else
		redirect_to controller:'sessions', action:'new'
	end
end

#週報検索
def search_week_or_month
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
	@project = params[:item][:project_id]
	@user = params[:item][:user_id]
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
		if @project.blank?
			if @user.blank?
				@all_reports = WeekReport.where(["start_day = ?", @start_day])
			else
				@all_reports = WeekReport.where(["start_day = ? and user_id = ?", @start_day, @user])
			end
		else
			if @user.blank?
				@all_reports = WeekReport.where(["start_day = ? and project_id = ?", @start_day, @project])
			else
				@all_reports = WeekReport.where(["start_day = ? and project_id = ? and user_id = ?", @start_day, @project, @user])
			end
		end
	end

	def judge_monthly
		if (2..8).include?(@start_day.end_of_month.day - @start_day.day) then
			flash.now[:info] = "この週は月報です"
		end
	end
#ファイル最終行のend
end
