class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.integer :code

      t.timestamps
    end
  end
end
