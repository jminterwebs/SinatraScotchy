class CreateDistiller < ActiveRecord::Migration
  def change
    create_table :distiller do |t|
      t.string :name
      t.integer :scotch_id
    end
  end
end
