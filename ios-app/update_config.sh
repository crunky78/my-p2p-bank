#!/bin/bash

# 1. 현재 로컬 IP 가져오기
IP=$(ipconfig getifaddr en0)

# 2. config.json 템플릿 기반으로 IP 삽입
TEMPLATE_PATH="./config.template.json"
OUTPUT_PATH="./MyP2PBank/config.json"  # 실제 config.json 위치로 수정

if [ -f "$TEMPLATE_PATH" ]; then
  sed "s/__IP__/$IP/g" "$TEMPLATE_PATH" > "$OUTPUT_PATH"
  echo "✅ config.json updated with IP: $IP"
else
  echo "❌ Template file not found!"
fi
