class CreateUpdateComments < ActiveRecord::Migration
  def change
    add_column :comments, :commenter, :string
  end
end
