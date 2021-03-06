module SessionsHelper
	def log_in(user)
		session[:user_id] = user.id
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def log_out
		forget(current_user)
	    session.delete(:user_id)
	    @current_user = nil
	end

	def remember(user)
	    user.remember
	    cookies.permanent.signed[:user_id] = user.id
	    cookies.permanent[:remember_token] = user.remember_token
	end

	def current_user
  		#if @current_user.nil?
		#   @current_user = User.find_by(id: session[:user_id])
		#else
		#   @current_user
		#end
	    if (user_id = session[:user_id])
	    	@current_user ||= User.find_by(id: user_id)
	    elsif (user_id = cookies.signed[:user_id])
	    	user = User.find_by(id: user_id)
	    	if user && user.authenticated?(cookies[:remember_token])
	        	log_in user
	        	@current_user = user
	      	end
	    end
	end

	def logged_in?
		!current_user.nil?
	end

	def current_user?(user)
	   	user == current_user
	end

	# Sth Wrong with argument
	#def admin?
	#	(current_user == User.find_by(id: 1))
	#end

	# 重定向到存储的地址，或者默认地址
	def redirect_back_or(default)
	  redirect_to(session[:forwarding_url] || default)
	  session.delete(:forwarding_url)
	end
	
	# 存储以后需要获取的地址
	def store_location
	  session[:forwarding_url] = request.url if request.get?
	end
end
