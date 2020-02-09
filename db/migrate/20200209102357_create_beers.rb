class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|

      t.string :name
      t.string :tagline
      t.text :description
      t.decimal :abv
      t.string :iduser
      t.timestamp :see_at
      t.boolean :favorite

      t.timestamps
    end
  end
end
