class UsersController < ApplicationController
  layout "main"
  before_action :signed_in_user,
                only: [:index,:edit, :update, :show, :courses]
  before_action :correct_user,   only: [:edit, :update, :show, :courses]
  before_action :admin_user,     only: [:destroy, :index, :edit]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    
    #if user is admin accessing other's page, go straight to edit
    if (!current_user?(@user) && current_user.admin? )
      redirect_to :controller => 'users', :action => 'edit', :id => params[:id] 
    end  
    
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  #---------Course Management-----------------------#

  #GET /users/:id/courses/
  def courses
    store_location
    @user = User.find(params[:id])
    @courses = @user.courses #Course.where(user_id: params[:id])
  end
  
  def register
    #render :nothing => true
    if params[:course].present?
      @course = Course.find(params[:course])
      current_user.courses << @course unless current_user.courses.include?(@course)
      current_user.save
      
      respond_to do |format|
        format.html { redirect_back_or courses_url, notice: 'Register was successful.' }
        format.json { head :no_content }   
      end   
      
    end
  end
  
  def drop 
    #render :nothing => true 
    if params[:course].present?
      @course = Course.find(params[:course])
      current_user.courses.delete(@course)
      current_user.save
      
      respond_to do |format|
        format.html { redirect_back_or courses_url, notice: 'Drop was successful.' }
        format.json { head :no_content }   
      end         
      
    end
  end
  

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
   
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :address, :city, :state, :zip_code, :role)
    end
    
     # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end
   
    def admin_user
      redirect_to(root_url) unless current_user.admin?    
    end
    
    
       
    
    
end
