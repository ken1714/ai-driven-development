#!/bin/bash

# デイリースクラム自動化スクリプト

daily-scrum() {
    local session_name="ds"
    local log_dir="./scrum-logs"
    
    echo "🏃‍♀️ デイリースクラム開始 - セッション: $session_name"
    
    # ログディレクトリ作成
    mkdir -p "$log_dir"

    # 議事録作成
    local minute_txt="./$log_dir/daily-scrum_$(date +%Y%m%d).md"
    touch "$minute_txt"
    
    # tmuxセッション作成と4エージェント配置（2x2グリッド）
    tmux new-session -d -s "$session_name" -n main

    tmux splitw -h    # 水平分割
    tmux select-pane -t 0
    tmux splitw -v    # 左側垂直分割
    tmux select-pane -t 2
    tmux splitw -v    # 右側垂直分割

    echo "セッション作成完了"
    
    # Agent役割設定
    local agents=("product-owner" "scrum-master" "developer" "quality")
    
    echo "エージェントの起動中..."
    
    # 全エージェントでclaude起動（並列）
    for i in "${!agents[@]}"; do
        tmux send-keys -t "$session_name.$i" "claude --dangerously-skip-permissions" Enter
        tmux send-keys -t "$session_name.$i" Enter
    done
    
    sleep 20  # claude起動待機
    
    # 全エージェントでコマンド実行（並列）
    for i in "${!agents[@]}"; do
        tmux send-keys -t "$session_name.$i" "/${agents[$i]}" Enter
        tmux send-keys -t "$session_name.$i" Enter
    done

    sleep 2

    tmux send-keys -t "$session_name.1" "デイリースクラムを始めます。議事録は必ず'$minute_txt'に残してください。" Enter
    tmux send-keys -t "$session_name.1" Enter

    echo "全エージェント起動完了"
}

daily-scrum;
