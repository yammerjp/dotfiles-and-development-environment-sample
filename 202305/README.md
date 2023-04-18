# 第5回 テキストエディタをカスタマイズする

VSCodeとVimの設定ファイルに変更を加えてカスタマイズします。

## VSCode

### VSCodeの設定カスタマイズ: テーマの変更

記事内で編集したVSCodeの設定ファイルの内容は以下のとおりです。

```json
{
    "workbench.colorTheme": "Default High Contrast Light"
}
```

```json
{
    "workbench.colorTheme": "Red"
}
```

なお、設定ファイルはコマンドパレット(F1を押下して開く)から「Preferences: Open User Settings(JSON)」を選択して開くことができます。

## Vim

### Vimの設定カスタマイズ: 行番号を表示する / コマンドラインモードを使ってカラースキームを試す


記事内で編集したVimの設定ファイル(`~/.vimrc`)の内容は以下のとおりです。

```.vimrc
set number
colorscheme pablo
```

### Vimの設定の同期

Vimをdotfilesリポジトリへ追加する手順は以下の通りです。

```shell
# 設定ファイルをdotfilesディレクトリへ移動する
$ mv~/.vimrc ~/dotfiles/.vimrc

# 移動した設定ファイルからホームディレクトリ上へシンボリックリンクを貼り、Vimを起動したときに設定が読み込まれるようにする
$ ln -s ~/dotfiles/.vimrc ~/.vimrc

# dotfilesディレクトリへ移動する
cd ~/dotfiles

# .vimrcファイルをGitリポジトリへ追加する
$ git add .vimrc

# .vimrcファイルの追加をコミットする
$ git commit -m ".vimrcを追加"

# .vimrcファイルの追加をリモートリポジトリへ反映する
$ git push origin main
```
