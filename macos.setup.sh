#!/bin/bash
set -e
echo "開発環境を構築します"
# ~/dotfilesにファイルやディレクトリが存在しないとき、リポジトリをクローンする
DOTFILES_REPO="$HOME/dotfiles"
if [ ! -e "$DOTFILES_REPO" ]; then
  echo 'dotfilesリポジトリをcloneします'
  # 次行に含まれるURLは、あなたのGitHubリポジトリのものに置き換えて記述する
  git clone https://github.com/<GitHubユーザ名>/<リポジトリ名>.git ~/dotfiles
  # 例えば筆者の場合、次行のようになる
  # git clone https://github.com/yammerjp/dotfiles.git ~/dotfiles
fi

# 設定ファイルごとにシンボリックリンクを作成する
cd "$DOTFILES_REPO"
git ls-files | grep -e '^\.' | while read DOTFILE; do # 13行目
  echo "シンボリックリンクを貼ります: $DOTFILE"
  ln -sf "$DOTFILES_REPO/$DOTFILE" "$HOME/$DOTFILE"
  # -sオプションは、シンボリックリンクの作成を表す
  # -fオプションは、作成先にファイルがあるとき、それを削除してから実行することを表す
done # 18行目

BREWFILE="$HOME/.Brewfile"
# 出力するファイル名にホスト名を含める場合は、前行の代わりに次行を記述する
# BREWFILE="$HOME/.Brewfile.$(hostname)"
if [ -e "$BREWFILE" ]; then
  echo "Homebrewパッケージを一括でインストールします"
  brew bundle  --file "$BREWFILE"
fi

echo "環境構築が完了しました！"
