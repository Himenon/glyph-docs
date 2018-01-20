# glyph-docs

[![Build Status](https://travis-ci.org/Himenon/glyph-docs.svg?branch=master)](https://travis-ci.org/Himenon/glyph-docs)

```bash
$ docker-compose up
```

確認: <http://localhost:8000>

## Deploy to Heroku


```bash
# Step 1 : mkdocs build
$ docker-compose run mkdocs mkdocs build

# Step 2 : Local Test
$ docker build . -t tfdocs:latest

# Step 3 : Local run
$ docker run -p 8080:8080 -e PORT=8080 tfdocs:latest
# Access : http://localhost:8080

# Step 4 : Deploy
$ heroku container:push web --arg SERVER_HOST=[SERVER_HOST],BASIC_PASS='[BASIC_PASS]'
```