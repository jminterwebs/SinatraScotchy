class CreateComments < ActiveRecord::Migration
  def change
    t.string :content
    t.integer :user_id
    t.integer :scotch_id
  end
end
