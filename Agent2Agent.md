# Agent2Agent.md
## Agent間通信システム仕様
### 概要

tmuxの画面分割とsend-keys機能を使ってAIエージェント間のリアルタイム対話を実現する。

## 基本構成

### 画面分割パターン

分割の方法はあくまで一例。すでに分割している場合は分割しなくて良い。

```bash
# 水平分割でAgent配置
tmux splitw -h  # ProductOwner | Developer
tmux splitw -v  # ProductOwner | Developer
                #              | Quality

# 4エージェント配置例
tmux splitw -h    # Main | Agent1
tmux select-pane -t 1
tmux splitw -v    # Main | Agent1
                  #      | Agent2  
tmux select-pane -t 0
tmux splitw -v    # Main | Agent1
                  # Agent3| Agent2
```

## Agent起動と通信

前提として、`tmux send-keys`を用いてコマンドを実行する際は、コマンドの内容をsend-keysすることに加えて、Enterをもう1度send-keysする必要があるので注意が必要。

### Agent起動

```bash
# 各ペインでAgent起動
tmux send-keys -t 0 "claude" Enter
tmux send-keys -t 0 Enter

# Claudeコマンドでの起動時間だけ待つ
sleep 1

# Product Ownerの場合の例。他のroleについても同様
tmux send-keys -t 0 "/product-owner" Enter
tmux send-keys -t 0 Enter
```

### Agent間メッセージ送信

各ロールでメッセージのやり取りを行う必要がある場合は、`tmux send-keys`を活用すること。しかし、ダイレクトメッセージの形になってしまうので、議事録は必ずファイルに残すこと。

```bash
# ProductOwnerからDeveloperへメッセージ送信
tmux send-keys -t 1 "ユーザーストーリー「ログイン機能」の技術的実現可能性を評価してください。優先度：高" Enter
tmux send-keys -t 1 Enter

# DeveloperからQualityへテスト要件確認
tmux send-keys -t 2 "ログイン機能のテストケース設計をお願いします。認証方式：OAuth2.0" Enter
tmux send-keys -t 2 Enter

# QualityからProductOwnerへ品質基準確認
tmux send-keys -t 0 "ログイン機能の受け入れ基準を明確化してください" Enter
tmux send-keys -t 0 Enter
```
