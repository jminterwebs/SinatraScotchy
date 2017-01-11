class ModifyScotches < ActiveRecord::Migration
  def change
    add_column :scotches, :region, :string
  end
end
