class AddBlogToComment < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :blog, foreign_key: true
  end
end
