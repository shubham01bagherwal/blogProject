class AddEmailConfirmationToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_confirmation, :boolean, default: false
    add_column :users, :confirm_token, :string
  end
end
