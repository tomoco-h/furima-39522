# README

## users テーブル

| Column               | Type   | Options                   |
| -------------------- | ------ | ------------------------- |
| nickname             | string | null: false               |
| email                | string | null: false, unique: true |
| encrypted_password   | string | null: false               |
| last_name            | string | null: false               |
| first_name           | string | null: false               | 
| last_name_kana       | string | null: false               |
| first_name_kana      | string | null: false               |
| birthday             | date   | null: false               |

### Association
- has_many :items
- has_many :orders


## items テーブル
| Column        | Type        | Options                        |
| ------------- | ----------- | ------------------------------ |
| item          | string      | null: false                    |
| explanation   | text        | null: false                    |
| category_id   | integer     | null: false                    |
| condition_id  | integer     | null: false                    |
| charge_id     | integer     | null: false                    |
| prefecture_id | integer     | null: false                    |
| shipping_id   | integer     | null: false                    |
| price         | integer     | null: false                    |
| user          | references  | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## addresses テーブル
| Column          | Type        | Options                        |
| --------------- | ----------- | ------------------------------ |
| post_code       | string      | null: false                    |
| prefecture_id   | integer     | null: false                    |
| municipalities  | string      | null: false                    |
| street_address  | string      | null: false                    |
| building_name   | string      |                                |
| phone           | string      | null: false                    |
| order           | references  | null: false, foreign_key: true |

### Association
- belongs_to :order

## orders テーブル
| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user       | references | null: false, foreign_key: true |
| item       | references | null: false, foreign_key: true |

### Association
- has_one :address
- belongs_to :user
- belongs_to :item