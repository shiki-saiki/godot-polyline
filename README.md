# 線分分割

線分を再帰的に分割することでフラクタル図形を作るアプリです。

[Godot](https://godotengine.org/)で作りました。

アイデアの元となったもの:

- [L-system](https://ja.wikipedia.org/wiki/L-system)
- [コッホ曲線](https://ja.wikipedia.org/wiki/%E3%82%B3%E3%83%83%E3%83%9B%E6%9B%B2%E7%B7%9A)
- [ドラゴン曲線](https://ja.wikipedia.org/wiki/%E3%83%89%E3%83%A9%E3%82%B4%E3%83%B3%E6%9B%B2%E7%B7%9A)

製作期間: 約2週間

## バイナリーファイルのダウンロード

[v1.0.0](https://github.com/shiki-saiki/godot-polyline/releases/tag/v1.0.0)


## 操作方法

- Q: パネルを表示/非表示
- D: 線分分割
- ドラッグ: 移動
- マウスホイール: ズームイン/アウト
- パネル中の形をクリック: 形を切り替え（リセット）

パネルは線分分割のルールを表しています。  
線分分割をすると左の線分が右の線分に置き換えられます。  
この置き換えはキャンバス中のすべての線分に適用されます。

![division.gif](/assets/division.gif)
