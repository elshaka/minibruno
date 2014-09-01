class UsersController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :set_roles, except: [:destroy]

  def index
    @users = User.registered.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'Usuario creado con éxito.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'Usuario actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_url }
        format.json { head :no_content }
      else
        format.html { redirect_to users_url, alert: 'No se puede eliminar el usuario porque tiene registros asociados' }
        format.json { head :no_content, status: :bad_request }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_roles
      @roles = User::ROLES
    end

    def user_params
      params.require(:user).permit([:username, :fullname, :role_id, :password, :password_confirmation])
    end
end
