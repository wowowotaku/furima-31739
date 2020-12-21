# README

## users table

| column             | Type    | Options                   |
|--------------------|---------|---------------------------|
| user_name          | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birthday           | date    | null: false               |

### Association
  has_many :products
  has_many :buy_records


## products table

| Column          | Type        | Options           |
|-----------------|-------------|-------------------|
| product_name    | string      | null: false       |
| category_id     | string      | null: false       |
| explain         | text        | null: false       |
| price           | integer     | null: false       |
| user            | references  | foreign_key: true |
| status_id       | integer     | null: false       |
| shipping_fee_id | integer     | null:false        |
| from_id         | integer     | null:false        |
| day_id          | integer     | null:false        |

### Association
  belongs_to :user
  has_one :buy_record


## buy_record table

| Column   | Type        | Options           | 
|----------|-------------|-------------------|
| user     | references  | foreign_key: true |
| product  | references  | foreign_key: true | 

### Association
  belongs_to :user
  belongs_to :product
  has_one :send_to


## send_to table

| Column        | Type       | Options           |
|---------------|------------|-------------------|
| postcode      | string     | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| block         | string     | null:false        |
| building      | string     |                   |
| phone_number  | string     | null: false       |
| buy_record    | references | foreign_key: true |


### Association
  belongs_to :buy_record
