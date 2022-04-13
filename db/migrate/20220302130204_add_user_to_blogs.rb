class AddUserToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_reference :blogs, :user
  end
end
 