#!/bin/bash

# 破棄処理
docker compose -p "vv-bug" down --rmi all --remove-orphans --volumes --timeout 15

# キャッシュなしでビルド
DOCKER_BUILDKIT=1 docker compose -p "vv-bug" -f ./compose.yml build --no-cache

# 起動
DOCKER_BUILDKIT=1 docker compose -p "vv-bug" -f ./compose.yml up -d
