class AddColumnToBlog < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :likes, :integer
  end
end
