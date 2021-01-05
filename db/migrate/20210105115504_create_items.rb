class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :item_name,       null: false
      t.integer    :category_id,     null: false
      t.text       :explain,         null: false
      t.integer    :price,           null: false
      t.references :user,            foreign_key: true
      t.integer    :status_id,       null: false
      t.integer    :shipping_fee_id, null: false
      t.integer    :from_id,         null: false
      t.integer    :day_id,          null: false
      t.timestamps
    end
  end
end
