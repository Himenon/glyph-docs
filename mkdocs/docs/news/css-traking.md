# WEBページのトラッキングできるCSSの考察

!!! note

    間違っていたらご指摘ください。

2018/01/19のcolissさんの記事で紹介されていた、

- [CSSのこのアイデアはすごすぎる！Webページのトラッキング・解析ができるスタイルシート -Crooked Style Sheets
](http://coliss.com/articles/build-websites/operation/css/css-tracking-and-analytics-web-page-crooked.html)

の記事について考察してみる。

紹介されているコードは下記

- [jbtronics/CrookedStyleSheets | Github](https://github.com/jbtronics/CrookedStyleSheets)
    - [Demo Site](http://crookedss.bplaced.net/)

## とりあえず試してみた感想

__おもしろみ__

- CSSの`url`の使い方がエモい()

<https://github.com/jbtronics/CrookedStyleSheets/blob/master/screen.css#L24-L26>

```css
#link2:active::after {
    content: url("track.php?action=link2_clicked");
}
```

__メリット__

- 既存のコードを変えずに追加するだけでできるのはありがたい。
- JavaScriptが切られている環境でも動く
- VDOMでレンダリングしたDOMに対しても有効

__デメリット__

- GETリクエストなので、URLわかっちゃったら直接リクエストできる
    - 裏を返せば、「何回クリックした」というトラッキングはしない
- ページ間の遷移は別途作らないといけないっぽい
- 外部リンク(ページごと変わる)はトラッキングできない


__注意点__

Githubのサンプルをそのままプロジェクトにぶち込んだら、名前空間汚染されちゃうのと、不必要なデータを取得する可能性があるので、名前空間を切って導入しておいたほうがいいかなぁ、と思う。

例えば、厳密にユーザーの行動のみをトラッキングしたいのであれば、JS側から自動でクリックしているところがあると、それは除外すべきなので、本当にクリックしているところのみにこのCSSを組み込むべきと考えられる。









