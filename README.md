# README

## users テーブル

| Column        | Type   | Options                   |
| ------------- | ------ | ------------------------- |
| nickname      | string | null: false               |
| email         | string | null: false, unique: true |
| password      | string | null: false               |
| lastname      | string | null: false               |
| firstname     | string | null: false               | 
| lastnamekana  | string | null: false               |
| firstnamekana | string | null: false               |
| birthday      | string | null: false               |

### Association
- has_many :items
- has_many :oders


## items テーブル
| Column      | Type       | Options                        |
| ----------- | ------     | ------------------------------ |
| item        | string     | null: false                    |
| explanation | text       | null: false                    |
| category    | string     | null: false                    |
| state       | string     | null: false                    |
| charge      | string     | null: false                    |
| region      | string     | null: false                    |
| days        | string     | null: false                    |
| price       | string     | null: false                    |
| user_id     | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- has_one :oders 

## address テーブル
| Column         | Type   | Options     |
| -------------- | ------ | ----------- |
| postcode       | string | null: false |
| prefectures    | string | null: false |
| municipalities | string | null: false |
| streetaddress  | string | null: false |
| buildingname   | text   |             |
| phone          | string | null: false |

### Association
has_one :oders

## oders テーブル
| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user_id    | references | null: false, foreign_key: true |
| item_id    | references | null: false, foreign_key: true |
| address_id | referenced | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items
- belongs_to :address