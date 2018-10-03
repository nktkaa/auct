class CreateBids < ActiveRecord::Migration[5.1]
  def change
    create_table :bids do |t|
      t.decimal :bid, :precision => 8, :scale => 2
      t.belongs_to :item, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
