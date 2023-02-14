BREWFILE="$HOME/.Brewfile"
# 出力するファイル名にホスト名を含める場合は、前行の代わりに次行を記述する
# BREWFILE="$HOME/.Brewfile.$(hostname)"
function brew-bundle-dump() {
  # --forceオプションをつけて、ファイルが存在したときは上書きする
  command brew bundle dump --file "$BREWFILE" --force
}

# シェル関数brewは、実行ファイルbrewよりも優先される
brew() {
  # シェル関数brewではなく実行ファイルbrewを実行する
  command brew $@
  # パッケージの一覧をファイルに出力する
  brew-bundle-dump
}

