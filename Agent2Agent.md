# Agent2Agent.md

## Agent間通信システム仕様

### 概要
tmuxの画面分割とsend-keys機能を使ってAIエージェント間のリアルタイム対話を実現する。

## 基本構成

### 画面分割パターン
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

### Agent起動
```bash
# 各ペインでAgent起動
tmux send-keys -t 0 "claude --role product-owner" Enter
tmux send-keys -t 1 "claude --role developer" Enter  
tmux send-keys -t 2 "claude --role quality" Enter
tmux send-keys -t 3 "claude --role scrum-master" Enter
```

### Agent間メッセージ送信
```bash
# ProductOwnerからDeveloperへメッセージ送信
tmux send-keys -t 1 "ユーザーストーリー「ログイン機能」の技術的実現可能性を評価してください。優先度：高" Enter

# DeveloperからQualityへテスト要件確認
tmux send-keys -t 2 "ログイン機能のテストケース設計をお願いします。認証方式：OAuth2.0" Enter

# QualityからProductOwnerへ品質基準確認
tmux send-keys -t 0 "ログイン機能の受け入れ基準を明確化してください" Enter
```

## Scrumイベント自動化

### Sprint Planning
```bash
#!/bin/bash
# sprint-planning.sh

# セッション開始
tmux new-session -d -s sprint-planning

# Agent配置（2x2グリッド）
tmux splitw -h
tmux select-pane -t 0
tmux splitw -v  
tmux select-pane -t 2
tmux splitw -v

# Agent起動
tmux send-keys -t 0 "# ProductOwner: バックログ優先順位付け" Enter
tmux send-keys -t 1 "# Developer: 技術的見積もり" Enter
tmux send-keys -t 2 "# Quality: テスト戦略" Enter  
tmux send-keys -t 3 "# ScrumMaster: 進行管理" Enter

# Planning開始
tmux send-keys -t 3 "Sprint Planning開始。Product Ownerから優先バックログアイテムを提示してください" Enter
```

### Daily Scrum
```bash
#!/bin/bash
# daily-scrum.sh

tmux new-session -d -s daily-scrum
tmux splitw -h
tmux splitw -v

# 各Agentから進捗報告収集
tmux send-keys -t 0 "昨日の成果と今日の予定を報告してください" Enter
tmux send-keys -t 1 "ブロッカーがあれば報告してください" Enter
tmux send-keys -t 2 "進捗状況を整理してチーム全体にフィードバックします" Enter
```

## 実装例

### Agent対話スクリプト
```bash
# 2エージェント対話
function start_agent_dialogue() {
    local agent1=$1
    local agent2=$2
    local topic=$3
    
    tmux new-session -d -s "${agent1}-${agent2}-dialogue"
    tmux splitw -h
    
    tmux send-keys -t 0 "# ${agent1}として${topic}について議論" Enter
    tmux send-keys -t 1 "# ${agent2}として${topic}について応答" Enter
    
    # 対話開始
    tmux send-keys -t 0 "${topic}について議論を開始します" Enter
}

# 使用例
start_agent_dialogue "product-owner" "developer" "ユーザー認証機能の要件"
```

### セッション監視
```bash
# リアルタイム監視
tmux capture-pane -t sprint-planning:0 -p  # ProductOwner出力
tmux capture-pane -t sprint-planning:1 -p  # Developer出力

# ログ保存
tmux capture-pane -t sprint-planning -p > logs/sprint-planning-$(date +%Y%m%d).log
```

## 運用ガイドライン

### セッション管理
- `tmux ls`でアクティブセッション確認
- `tmux attach -t <session-name>`でセッション参加
- `Ctrl-b d`でセッションデタッチ（バックグラウンド継続）

### Agent切り替え
- `Ctrl-b o`で次のペインに移動
- `Ctrl-b ;`で前回のペインに戻る
- `Ctrl-b q`でペイン番号表示

### セッション終了
```bash
# 結果保存してセッション終了
tmux capture-pane -t sprint-planning -p > results/sprint-planning-output.txt
tmux kill-session -t sprint-planning
```

この仕様により、tmuxの基本機能だけでAgent間の効率的な対話システムを構築できる。