class WeekReportsController < ApplicationController
before_action :signed_in_user
before_action :set_week_report, only: [:show, :edit, :update, :destroy]

#indexコントローラ
def index
	if signed_in?
		@start_day = Date.today.beginning_of_week
		@end_day = @start_day.end_of_week - 2
		@week_reports = WeekReport.where('user_id = ? AND start_day = ?', current_user.id, @start_day)
		session[:start_day] = @start_day
		judge_monthly
	else
		redirect_to controller:'sessions', action:'new'
	end
end

#指定の週報を表示
def change_week
	if signed_in?
		@start_day = Date.strptime(params[:start], "%Y-%m-%d").beginning_of_week
		@end_day = @start_day.end_of_week - 2
		@week_reports = WeekReport.where('user_id = ? AND start_day = ?', current_user.id, @start_day)
		session[:start_day] = @start_day
		judge_monthly
		render 'index'
	else
		redirect_to controller:'sessions', action:'new'
	end
end

#単体表示画面
def show
end

#新規作成画面用
def new
  	@week_report = WeekReport.new
	@start_day = Date.strptime(session[:start_day], "%Y-%m-%d")
	@end_day = @start_day.end_of_week - 2
	judge_monthly
end

# GET /week_reports/1/edit
def edit
	@start_day = Date.strptime(session[:start_day], "%Y-%m-%d")
	@end_day = @start_day.end_of_week - 2
	@project = @week_report.project_id
	judge_monthly
end

#新規作成
def create
	@week_report = WeekReport.new(week_report_params)
	@week_report.user_id = current_user.id
	if @week_report.save
		flash[:success] = "新しい項目が追加されました！"
	else
		flash[:danger] = "入力値が不正です！"
	end
	redirect_to controller:'week_reports', action:'change_week', start:session[:start_day]
end

#更新
def update
	if @week_report.update(week_report_params)
		flash[:success] = "正しく更新されました！"
	else
		flash[:danger] = "入力値が不正です！"
	end
	redirect_to controller:'week_reports', action:'change_week', start:session[:start_day]
end

#削除
def destroy
	@week_report.destroy
	flash[:success] = "正しく削除されました！"
	redirect_to controller:'week_reports', action:'change_week', start:session[:start_day]
end

#レコード複製
	def copy_item
		@start_day = Date.strptime(session[:start_day], "%Y-%m-%d")
		@week_reports = WeekReport.where('user_id = ? AND start_day = ?', current_user.id, @start_day - 1.week)
		@week_reports.each do |week_report|
			new_record =week_report.dup
			new_record.start_day = @start_day
			if new_record.save
			else
				flash[:danger] = "コピーに失敗しました！"
				redirect_to controller:'week_reports', action:'change_week', start:session[:start_day]
			end
		end
		flash[:success] = "正しくコピーされました！"
		redirect_to controller:'week_reports', action:'change_week', start:session[:start_day]
	end


  private
    def set_week_report
      @week_report = WeekReport.find(params[:id])
    end

	def judge_monthly
		if (2..8).include?(@start_day.end_of_month.day - @start_day.day) then
			flash.now[:info] = "今週は月報です"
		end
	end
    def week_report_params
	    params.require(:week_report).permit(:user_id, :project_id, :done, :understood, :next, :start_day)
    end
end
