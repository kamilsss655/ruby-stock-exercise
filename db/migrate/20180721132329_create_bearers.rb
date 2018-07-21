class CreateBearers < ActiveRecord::Migration[5.0]
  def change
    create_table :bearers do |t|
      t.string :name, null: false
      t.index :name, unique: true
      t.timestamps
    end
  end
end
