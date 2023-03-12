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
git ls-files | grep -e '^\.' | while read DOTFILE; do
  echo "シンボリックリンクを貼ります: $DOTFILE"
  ln -sf "$DOTFILES_REPO/$DOTFILE" "$HOME/$DOTFILE"
  # -sオプションは、シンボリックリンクの作成を表す
  # -fオプションは、作成先にファイルがあるとき、それを削除してから実行することを表す
done


echo "aptパッケージをインストールします"
# パッケージ更新時に出現する一部のダイアログ表示を抑制する
echo -e "\$nrconf{kernelhints} = '0';\n\$nrconf{restart} = 'a';" | sudo tee /etc/needrestart/conf.d/50-autorestart-tmp.conf
sudo apt-get update -y
# 連載第3回までで扱ったパッケージをインストールする
sudo apt-get install -y git
sudo apt-get install -y fzf
sudo apt-get install -y tmux
sudo apt-get install -y zsh
# 連載第3回で扱ったAlacrittyのビルドに必要なパッケージをインストールする
echo "Alacrittyのビルドに必要なパッケージをインストールします"
sudo apt-get install -y curl cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# cargoコマンドが定義されていない時のみ、インストールする
if ! which cargo > /dev/null ; then
  echo "cargoコマンドをインストールします"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable --no-modify-path
  echo 'source "$HOME/.cargo/env"' >> ~/.bashrc
  echo '~/.bashrcを更新しました'
  echo 'cargoやalacrittyを実行する前に、次のコマンドを実行してください'
  echo '    $ source ~/.bashrc'
fi

# alacrittyコマンドが定義されていない時のみ、インストールする
if ! which alacritty > /dev/null; then
  echo "Alacrittyをビルドし、インストールします"
  ~/.cargo/bin/cargo install alacritty
fi

# 設定ファイルを破棄し、パッケージ更新時に出現する一部のダイアログ表示の抑制を取り消す
sudo rm -f /etc/needrestart/conf.d/50-autorestart-tmp.conf

echo "環境構築が完了しました！"
