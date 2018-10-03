class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.decimal :start_price, :precision => 8, :scale => 2
      t.time :end_date
      t.belongs_to :user, index: true
      t.belongs_to :currency, index: true

      t.timestamps
    end
  end
end
