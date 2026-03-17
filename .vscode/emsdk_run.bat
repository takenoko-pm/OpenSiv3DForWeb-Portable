@echo off
:: このスクリプトの場所から emsdk フォルダへのパスを特定
set "EMSDK_DIR=%~dp0..\emsdk"

pushd "%EMSDK_DIR%"
:: 初回や移動後など、設定ファイルがない場合は自動でアクティベート
if not exist .emscripten (
    call emsdk activate 3.1.20
)
:: 環境変数を現在のプロセスに読み込む
call emsdk_env.bat > nul
popd

:: 渡された引数（emcc や node など）をそのまま実行
%*