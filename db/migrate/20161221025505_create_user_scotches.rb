class CreateUserScotches < ActiveRecord::Migration
  def change
    create_table :user_scotches do |t|
      t.integer :user_id
      t.integer :scotch_id
    end
  end
end
