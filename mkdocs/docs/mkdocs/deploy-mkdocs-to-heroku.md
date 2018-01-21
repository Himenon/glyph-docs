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


## エラー

```
Preparing deploy
Cleaning up git repository with `git stash --all`. If you need build artifacts for deployment, set `deploy.skip_cleanup: true`. See https://docs.travis-ci.com/user/deployment/#Uploading-Files.
No local changes to save
creating application archive
```

```
Deploying application
uploading application archive
...

=== Fetching app code failed
=!= Your app does not include a heroku.yml build manifest. To deploy your app, either create a heroku.yml: https://devcenter.heroku.com/articles/heroku-yml-build-manifest
Or change your stack by running: 'heroku stack:set heroku-16'
heroku build still pending
heroku build still pending
heroku build still pending
heroku build still pending
heroku build still pending
heroku build still pending
No stash entries found.
deploy failed, build exited with code 1
failed to deploy
```

