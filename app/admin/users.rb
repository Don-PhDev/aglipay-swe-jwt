ActiveAdmin.register User do
  menu priority: 4

  permit_params :email, :password, :password_confirmation

  controller do
    def create
      @user = User.new(permitted_params[:user])
      if @user.save
        redirect_to admin_user_path(@user), notice: "User created successfully."
      else
        render :new
      end
    end
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
