class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,     only: :destroy
  #before_action :logged_in_user, only: [:index, :exit, :update]
  # GET /users
  # GET /users.json
  def index
    if logged_in?
      #if admin?
      @users = User.paginate(page: params[:page], :per_page => 20)
      #else
       # redirect_to root_path
      #end
    else
      redirect_to root_path
    end
  end

  #def index
  #  @user = User.all
  #end

  # GET /users/1
  # GET /users/1.json
  def show
    if logged_in?
      @user = current_user#User.find(params[:id])
    else
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
    #debugger
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if logged_in?
      @user = current_user
    else
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    #respond_to do |format|
      if @user.save
        log_in @user
        flash[:success] = "User was successfully created!"
        redirect_to @user
        #format.html { redirect_to @user, notice: 'User was successfully created.' }
        #format.json { render :show, status: :created, location: @user }
      else
        render 'new'
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    #end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    #respond_to do |format|
      if @user.update(user_params)
        flash[:success] = "Profile Updated"
        redirect_to @user
    #    format.html { redirect_to @user, notice: 'User was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @user }
      else
        render 'edit'
    #    format.html { render :edit }
    #    format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    #end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
    #@user.destroy
    #respond_to do |format|
    #  format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    #  format.json { head :no_content }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end