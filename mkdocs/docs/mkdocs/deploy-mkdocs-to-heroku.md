# MkDocsをHerokuへデプロイする


前提：herokuアカウントを作成している


## Herokuのアプリを作成する

```bash
# appの作成
$ heroku create

# appの確認
$ heroku apps
```

## mkdocsをbuildする

```bash
# ドキュメントのビルド
$ docker-compose run mkdocs mkdocs build

# Dockerのビルド
$ docker build . -t tfdocs:latest
```

## Deploy

### travis-ci

`.travis.yml`を作成します

```bash
$ travis setup heroku
```

ドキュメントを呼んでも同じことができます。Dockerを利用する場合は`service`を指定する必要がある。

- https://docs.travis-ci.com/user/deployment/heroku/

# Script

ローカルからでもこれ単体で動きます。

```bash	
# Login
$ heroku container:login

# Basic認証あり
$ heroku container:push web --arg MKDOCS_SERVER=[SERVER_HOST],BASIC_PASS='[BASIC_PASS]'

# Basic認証なし
$ heroku container:push web --arg MKDOCS_SERVER=[SERVER_HOST]
```

CIに設定するときは、`SERVER_HOST`を環境変数から注入すると便利。

- `SERVER_HOST`: デプロイ先のホスト名
- `BASIC_PASS`: `htpasswd -c`で作成した文字列




