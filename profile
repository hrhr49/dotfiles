# .profileの内容
# 注意:どうもGUI環境のない状態でzshをインタラクティブシェルとして使うと
# .profileが読み込まれないみたい

# homebrew経由のpython3をデフォルトで使用するように、PATHの先頭にpython3のパスを追加
if [ -d "/home/linuxbrew/.linuxbrew/opt/python@3/libexec/bin" ] ; then
  export PATH="/home/linuxbrew/.linuxbrew/opt/python@3/libexec/bin:$PATH"
fi
