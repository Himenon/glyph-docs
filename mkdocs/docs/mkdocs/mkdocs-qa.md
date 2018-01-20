# MkDocsのQ&A

!!! warning "但し書き"
    間違っている所があれば、GithubもしくはTwitterまでご連絡ください。


## Q. MkDocsはブログに向いているか？

次の要件が満たされているかどうか調査中です。
また、下記の項目は他のQで応えます。

## Q. ディレクトリツリーから自動で生成されるか

mkdocs.ymlのpagesに手動入力する必要があります。
ただし、docs配下をスキャンするように自分で作れは可能。

## Q. Markdownで掛けるか

通常のMarkdownがベースです。
拡張機能でrstライクなSyntaxを増やすことも可能です。

## Q. 拡張機能は充実しているか？

こちらをご覧ください。

- <https://squidfunk.github.io/mkdocs-material/extensions/admonition/>

## Q. 外部のjsはどのように読み込むか？

全体に共通のJavaScriptならmkdocs.ymlの`extra_javascript`に記述することで対応できます。
個別の場合は、`<script>`タグをMarkdown中に埋め込むことで対応できます。

- <http://bwmarrin.github.io/MkDocsPlus/>

## Q. オススメのホスティングサービスは？

Publicなら、[Netlify](https://www.netlify.com/)がおすすめです。
Privateにしたいなら、コストを抑えるならHerokuなどにNginxとともにデプロイすると良いと覆います。



