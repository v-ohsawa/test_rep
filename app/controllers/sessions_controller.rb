class SessionsController < ApplicationController

	#newコントローラ
	def new
	end

	#createコントローラ
	def create
		user = User.find_by(worker_num: params[:session][:worker_num].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or root_url
		else
			flash.now[:danger] = '社員番号またはパスワードが正しくありません'
			render 'new'
		end
	end

	#destroyコントローラ
	def destroy
		sign_out
		redirect_to root_url
	end
end
