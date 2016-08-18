# mysqldoc
* Mysql 用のDB定義書出力スクリプト。
* `bin/config.sh` に記載された接続先のDBのテーブル定義をHTMLにて出力する。
*  DB名 mysql | information_schema | performance_schema | tmp は出力対象外。
* AWS Aurora などでも使えます。

# 使い方
* `bin/config.sh` の設定を適宜変更する
* `sh bin/mysqldoc.sh` を実行する

# テーブル/カラムの説明文について
* Mysql のテーブルコメント/カラムコメントを参照しています。

## テーブルコメントのつけかた
```
alter table TABLE_NAME comment 'テーブル名';
```

## カラムコメントのつけかた
```
create table TABLE_NAME (
  id INTEGER(10) primary key comment 'ID',
  data varchar(50) comment 'データ'
);
```

または

```
alter table TABLE_NAME modify id INTEGER(10) comment 'ID';
alter table TABLE_NAME modify data varchar(50) comment 'データ';
```

## 注意点
* 改行を入れたい場合には html タグで記述してください

ex)
```
create table TABLE_NAME (
    gender INTEGER(1) primary key comment '性別<br>1: 男性<br>2: 女性',        
);
```

