class CreateScotch < ActiveRecord::Migration
  def change
    create_table :scotches do |t|
      t.string :name
      t.string :age
      t.string :abv
    end
  end
end
