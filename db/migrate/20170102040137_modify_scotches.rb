class ModifyScotches < ActiveRecord::Migration
  def change
    add_column :scotches, :distiller_id, :integer
  end
end
