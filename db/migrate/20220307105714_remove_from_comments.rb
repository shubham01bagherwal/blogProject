class RemoveFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :blog_id
    #remove_column :comments, :user_id
    #remove_column :comments, :relation_id
    
  end
end
