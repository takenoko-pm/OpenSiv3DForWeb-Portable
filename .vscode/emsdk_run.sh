#!/usr/bin/env bash

# スクリプトの場所から emsdk フォルダへのパスを特定
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
EMSDK_DIR="$SCRIPT_DIR/../emsdk"

# emsdkサブモジュールのクローン（フォルダが空なら）
if [ ! -d "$EMSDK_DIR" ] || [ -z "$(ls -A "$EMSDK_DIR" 2>/dev/null)" ]; then
  git submodule update --init
fi

pushd "$EMSDK_DIR" > /dev/null

# 初回や移動後など、設定ファイルがない場合はインストール/アクティベート
if [ ! -f ".emscripten" ]; then
  ./emsdk install 3.1.20
  ./emsdk activate 3.1.20
fi

# 環境変数を現在のシェルに読み込む
source ./emsdk_env.sh > /dev/null

popd > /dev/null

# 渡された引数をそのまま実行
"$@"