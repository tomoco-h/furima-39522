# README

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| lastname           | string | null: false               |
| firstname          | string | null: false               | 
| lastnamekana       | string | null: false               |
| firstnamekana      | string | null: false               |
| birthday           | date   | null: false               |

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
| days_id       | integer     | null: false                    |
| price         | integer     | null: false                    |
| user          | references  | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## addresses テーブル
| Column         | Type        | Options                        |
| -------------- | ----------- | ------------------------------ |
| postcode       | string      | null: false                    |
| prefecture_id  | integer     | null: false                    |
| municipalities | string      | null: false                    |
| streetaddress  | string      | null: false                    |
| buildingname   | string      |                                |
| phone          | string      | null: false                    |
| item           | references  | null: false, foreign_key: true |

### Association
- has_one :order

## orders テーブル
| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user       | references | null: false, foreign_key: true |
| item       | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item