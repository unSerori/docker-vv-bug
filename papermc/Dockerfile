# base image
ARG BASE_IMAGE_JAVA
FROM ${BASE_IMAGE_JAVA}

# composeから変数を受け取る
ARG SERVER_URL
ARG PLUGINS

# 作業ディレクトリの設定
WORKDIR /opt/papermc

# 必要なファイルのコピー

# eula
COPY eula.txt .
# setting file gloval
COPY paper.yml .
# server setting
COPY server.properties .
# setting file papermc(:spigot.yml)
COPY spigot.yml .

# 必要なパッケージやリソースのダウンロードおよびインストール
RUN \ 
    # 必要なツール類
    apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y curl gcc git jq make python3.8-venv pipx \
    && pipx ensurepath \
    && pipx install yq \
    # サーバーのdl
    && curl -o server.jar "${SERVER_URL}" \
    # プラグインのdl
    && echo $PLUGINS > ./plugins.txt \
    && mkdir -p ./plugins/ \
    && for plugin in ${PLUGINS}; do curl -L -o "./plugins/$(basename ${plugin})" "$plugin"; done
# cronのビルド
# && mkdir -p /opt/mcrcon \
# && cd /opt/mcrcon \
# && git clone https://github.com/Tiiffi/mcrcon.git \
# && cd mcrcon \
# && make \
# && cp mcrcon /usr/local/bin/
ENV PATH=/root/.local/bin:$PATH

# スレーブのデフォルトポートの公開 Minecraftのデフォルトポートで、プロキシされたプレイヤーはここに接続される
EXPOSE 25565

# 実行用のスクリプトをコピー
COPY ./init.sh .
RUN \
    # 改行コードを揃えて、
    sed -i -e 's/\r//g' ./init.sh && \
    # 権限も変更
    chmod +x ./init.sh

# スクリプトで起動
ENTRYPOINT ["/bin/bash", "-c", "./init.sh"]
