# rails アプリケーション
## 準備が必要なもの
- docker for desktop
- docker-compose

## 必要ファイル作成
任意の場所にアプリ用ディレクトリ作成
```
mkdir deploy_app
cd mkdir
```

必要となるファイルは4つ
| ファイル | 用途 |
| :--- | :--- |
| Dockerfile | dockerのイメージを作成するためのファイル。build時に読み込まれる。|
| docker-compose.yml | 複数のコンテナを一括で管理する設定が書かれるファイル。|
| entrypoint.sh | ヘルパースクリプト。任意のシェルスクリプトを実行可能。|
| Gemfile | 使用するrubyのGemを管理するファイル。バージョン指定などが可能。|
| Gemfile.lock | 使用されたGemのインストール状況(依存関係等)が記述されるファイル。基本的にはrails側更新する。|



各ファイルの設定は以下の通り
- [Dockerfile](../Dockerfile)
- [docker-compose.yml](../docker-compose.yml)
- Gemfile
```Gemfile
source 'https://rubygems.org'
gem 'rails', '~> 6.1.6'
```

- Gemfile.lock
  - 空ファイルでよい

## コンテナの立ち上げ
```
docker-compose run web rails new . --force --no-deps --database=postgresql --skip-bundle
docker-compose build
```

## データベース設定
database.ymlファイルを編集
- [database.yml](../config/database.yml)

```
docker-compose run web rails db:create
```

## サーバーの立ち上げ
```
docker-compose up
```

localhost:3000で接続を確認

## 動作概要
本アプリは基本的なCRUDの機能を備えている。