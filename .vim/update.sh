#!/usr/bin/env bash
#
# Usage: ./update.sh [pattern]
#
# Specify [pattern] to update only repos that match the pattern.

repos=(

  Quramy/tsuquyomi
  airblade/vim-gitgutter
  alampros/vim-styled-jsx
  altercation/vim-colors-solarized
  ap/vim-css-color
  arcticicestudio/nord-vim
  docunext/closetag.vim
  ervandew/supertab
  haya14busa/incsearch.vim
  itchyny/lightline.vim
  jparise/vim-graphql
  junegunn/fzf.vim
  junegunn/fzf
  junegunn/goyo.vim
  mhartington/oceanic-next
  mileszs/ack.vim
  nathanaelkane/vim-indent-guides
  padde/jump.vim
  qpkorr/vim-bufkill
  scrooloose/nerdtree
  sheerun/vim-polyglot
  statico/vim-inform7
  tomasr/molokai
  tpope/vim-commentary
  tpope/vim-endwise
  tpope/vim-eunuch
  tpope/vim-fugitive
  tpope/vim-pathogen
  tpope/vim-repeat
  tpope/vim-rhubarb
  tpope/vim-sleuth
  tpope/vim-surround
  tpope/vim-unimpaired
  w0rp/ale
  wellle/targets.vim
  rhysd/accelerated-jk
  joonty/vdebug
  xolox/vim-misc
  xolox/vim-session
  xwsoul/vim-zephir
  vim-scripts/smarty-syntax
  majutsushi/tagbar.git
)

set -e
dir=~/.dotfiles/.vim/bundle

if [ -d $dir -a -z "$1" ]; then
  temp="$(mktemp -d -t bundleXXXXX)"
  echo "▲ Moving old bundle dir to $temp"
  mv "$dir" "$temp"
fi

mkdir -p $dir

for repo in ${repos[@]}; do
  if [ -n "$1" ]; then
    if ! (echo "$repo" | grep -i "$1" &>/dev/null) ; then
      continue
    fi
  fi
  plugin="$(basename $repo | sed -e 's/\.git$//')"
  [ "$plugin" = "vim-styled-jsx" ] && plugin="000-vim-styled-jsx" # https://goo.gl/tJVPja
  dest="$dir/$plugin"
  rm -rf $dest
  (
    git clone --depth=1 -q https://github.com/$repo $dest
    rm -rf $dest/.git
    echo "· Cloned $repo"
  ) &
done
wait
