class CreateScotch < ActiveRecord::Migration
  def change
    create_table :sctoch do |t|
      t.string :name
      t.string :age
      t.string :abv
    end
  end
end
