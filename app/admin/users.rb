ActiveAdmin.register User do
  permit_params :email, :created_at, :updated_at
  index do
    selectable_column
    id_column
    column :email
    column :user_name
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :email
      row :user_name
      row :created_at
      row :updated_at
    end
    div do
      form action: send_mail_admin_user_path, method: :get do |f|
        f.input :message_field, type: :text, name: 'message_field'
        f.input :submit, type: :submit
      end
    end
  end

  member_action :send_mail, method: :get do
    UserMailer.message_to_user(resource.email, params[:message_field]).deliver_later
    redirect_to admin_users_path
  end
end

