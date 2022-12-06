# === エイリアスを定義する ===

# duコマンドに、-h (人間に読みやすい単位の容量で表示する) オプションを付加する
alias du='du -h'
# bashの設定ファイルを編集するエイリアス .b を定義する (Vimを使う場合)
alias .b='vim ~/.bashrc'
# zshの設定ファイルを編集するエイリアス .z を定義する (Vimを使う場合)
alias .z='vim ~/.zshrc'



# === シェル関数を定義する ===

memo() {
    local MEMO_DIR="$HOME/memo"
    # ディレクトリが存在しない時のみ作成する
    mkdir -p "$MEMO_DIR"
    # 今日の日付を取得して、変数 TODAY に代入する
    local TODAY="$(date +%Y%m%d)"
    vim "$MEMO_DIR/$TODAY.md"
}



# === プロンプトを変更する ===

# a. 単純な表示

# 変数 PS1 に'$ 'を代入する
# PS1='$ '
# 設定する場合は、他のプロンプトの設定をコメントアウトし、上の行の、先頭の # を取る


# b. 現在時刻などの表示

# 変数 PS1 に、ユーザ名、ホスト名、現在時刻、カレントディレクトリなどを表す特殊文字を指定する
# PS1='[%n@%m %* %c]%(!.#.$) '
# 設定する場合は、他のプロンプトの設定をコメントアウトし、上の行の、先頭の # を取る


# c. Gitのブランチ名を表示

# 事前に、次に示すコマンドを実行し、GitHub上にあるスクリプトを ~/.git-prompt.sh に配置する
# ①と②のうち、どちらかを実行する
# ① curlが利用できる場合
# curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
# ② wgetが利用できる場合
# wget -O ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

# ~/.git-prompt.sh を読み込んで、__git_ps1コマンドを利用できるようにする
source ~/.git-prompt.sh
# プロンプト表示前に、ブランチ名をPS1に代入する
precmd () { __git_ps1 "[%n@%m %* %~" "]%(!.#.\$) " }



# === フィルターコマンドを活用する ===

# 以下のコマンドなどで、事前にfzfをインストールしておく
# brew install fzf
# sudo apt install fzf
# https://github.com/junegunn/fzf

# a. Gitのブランチをfzfで絞り込む

# fzfを用いたブランチの絞り込みコマンドを、ターミナル上で実行して試す
# --formatオプションをつけて、出力がブランチ名のみになるようにしている
# git branch --all --format="%(refname:short)" | fzf | xargs git checkout

# Gitのエイリアスとして、ブランチの選択を行うswサブコマンドを登録する
# コマンド中の「!」は、Gitのエイリアスの中でシェルコマンドを記述するときに用いる表記
# git config --global alias.sw '!git branch --all --format="%(refname:short)" | fzf | xargs git checkout'

# b. コマンドの実行履歴をfzfで絞り込む

select-history() {
  # コマンドの実行履歴をfzfで選択し、コマンドラインへ書き込む
  BUFFER=$(history -n -r 1 | fzf --query "$BUFFER")
  # カーソルをコマンドラインの右端に移動
  CURSOR=$#BUFFER
}
# シェル関数にキーボードショートカット Ctrl-R を割り当てる
zle -N select-history
bindkey '^r' select-history
