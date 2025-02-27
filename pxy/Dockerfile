# base image
ARG BASE_IMAGE_JAVA
FROM ${BASE_IMAGE_JAVA} AS deploy

# composeから変数を受け取る
ARG PROXY_SERVER_URL
ARG PLUGINS

# 作業ディレクトリの設定
WORKDIR /opt/pxy

# 必要なファイルのコピー
# COPY server-icon.png .
# COPY config.yml .
COPY velocity.toml .

# 必要なパッケージやリソースのダウンロードおよびインストール
RUN \
    # 必要なツール類
    apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y curl git \
    # サーバーのDL
    && curl -o pxy.jar -L "${PROXY_SERVER_URL}" \
    # プラグインのDL
    && echo $PLUGINS > ./plugins.txt \
    && mkdir -p ./plugins/ \
    && for plugin in ${PLUGINS}; do curl -L -o "./plugins/$(basename ${plugin})" "$plugin"; done
ENV PATH=/root/.local/bin:$PATH

# プロキシのデフォルトポートの公開 ここにプレイヤーが接続しプロキシされる
EXPOSE 25565

# 起動時に鯖実行
# CMD [ "java", "-Xmx512M", "-Xms512M", "-jar", "velocity.jar" ]
CMD [ "java", "-Xmx512M", "-Xms512M", "-jar", "pxy.jar" ] 
# java -Xmx512M -Xms512M -jar pxy.jar
# CMD [ "sleep", "infinity" ]
