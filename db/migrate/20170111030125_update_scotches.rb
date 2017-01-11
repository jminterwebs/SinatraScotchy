class UpdateScotches < ActiveRecord::Migration
  def change
    add_column :scotches, :comment_id, :integer
  end
end
