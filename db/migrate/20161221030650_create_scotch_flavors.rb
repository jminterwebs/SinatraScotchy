class CreateScotchFlavors < ActiveRecord::Migration
  def change
    create_table :scotch_flavors do |t|
      t.integer :scotch_id
      t.integer :flavor_id
    end
  end
end
