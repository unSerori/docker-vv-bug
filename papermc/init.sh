#!/bin/bash

# 停止シグナルのハンドル
stop_handler(){
    echo "Terminating process with PID: ${JAVA_PID}..."
    kill -s TERM $JAVA_PID
    wait $JAVA_PID
    echo "Process with PID: ${JAVA_PID} has been terminated."
}

# log
mkdir -p /var/log/
echo "DATE: $(date)" 2>&1 | tee -a /var/log/execute.log # datetime
echo "PWD: $(pwd)" 2>&1 | tee -a /var/log/execute.log   # /opt/copy
echo "Checking directories: /opt/" 2>&1 | tee -a /var/log/execute.log
find /opt/ -maxdepth 0 -exec ls -la {} + 2>&1 | tee -a /var/log/execute.log # ls -la /opt/
echo "Checking directories: /opt/papermc" 2>&1 | tee -a /var/log/execute.log
find /opt/papermc -maxdepth 0 -exec ls -la {} + 2>&1 | tee -a /var/log/execute.log # ls -la /opt/papermc/

# シグナルハンドリング
trap stop_handler SIGTERM SIGINT

# change work dir
sh_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # 実行場所を相対パスで取得し、そこにサブシェルで移動、pwdで取得
cd "$sh_dir" || {
    echo "Failure CD command."
    exit 1
}

# 何らかの処理

# yamlにシークレットを書き込む

# 変数に値を取得
secret_value=$(head -n 1 ./forwarding.secret)
# -y: yaml output -i: 上書き
yq -yi '.settings."velocity-support".secret |= "'${secret_value}'"' ./paper.yml
pwd 2>&1 | tee -a /var/log/execute.log

# メインプロセスを実行
java -Xmx2048M -Xms1024M -jar server.jar &
# JavaプロセスのPIDを取得
JAVA_PID=$!
echo "\$JAVA_PID: ${JAVA_PID}" 2>&1 | tee -a /var/log/execute.log # process id

# 子プロセスの終了を待つ
wait $JAVA_PID