class CreateBuyRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :buy_records do |t|

      t.timestamps
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true
    end
  end
end
