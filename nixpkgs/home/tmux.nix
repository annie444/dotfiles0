{ config, lib, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = false;
    escapeTime = 0;
    historyLimit = 20000;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    sensibleOnTop = true;
    secureSocket = false;
    prefix = "C-a";
    shortcut = "a";
    terminal = "screen-256color";
    tmuxinator = {
      enable = true;
    };
    extraConfig = ''
      set -g buffer-limit 20
      set -g display-time 1500
      set -g remain-on-exit off
      set -g repeat-time 300
      setw -g allow-rename off
      setw -g automatic-rename off
      set -g set-titles on
      set -g set-titles-string "#I:#W"
      unbind "\$" # rename-session
      unbind ','    # rename-window
      unbind '%'    # split-window -h
      unbind '"'  # split-window
      unbind '}'    # swap-pane -D
      unbind '{'    # swap-pane -U
      unbind ']'    # paste-buffer
      unbind '['    
      unbind "'"  # select-window
      unbind n    # next-window
      unbind p    # previous-window
      unbind l    # last-window
      unbind M-n  # next window with alert
      unbind M-p  # next window with alert
      unbind o    # focus thru panes
      unbind '&'  # kill-window
      unbind "#"  # list-buffer 
      unbind '='    # choose-buffer
      unbind z    # zoom-pane
      unbind M-Up  # resize 5 rows up
      unbind M-Down # resize 5 rows down
      unbind M-Right # resize 5 rows right
      unbind M-Left # resize 5 rows left
      bind c new-window -c "#{pane_current_path}"
      set-hook -g after-new-window 'command-prompt -I "#{window_name}" "rename-window '%%'"'
      bind r command-prompt -I "#{window_name}" "rename-window '%%'"
      bind R command-prompt -I "#{session_name}" "rename-session '%%'"
      bind | split-window -h -c "#{pane_current_path}"
      bind _ split-window -v -c "#{pane_current_path}"
      bind -r C-[ previous-window
      bind -r C-] next-window
      bind -r [ select-pane -t :.-
      bind -r ] select-pane -t :.+
      bind -r Tab last-window   # cycle thru MRU tabs
      bind -r C-o swap-pane -D
      bind + resize-pane -Z
      bind L command-prompt -p "Link window from (session:window): " "link-window -s %% -a"
      bind '\' if '[ #{pane_index} -eq 1 ]' \
           'swap-pane -s "!"' \
           'select-pane -t:.1 ; swap-pane -d -t 1 -s "!"'
      bind x kill-pane
      bind X kill-window
      bind C-x confirm-before -p "kill other windows? (y/n)" "kill-window -a"
      bind Q confirm-before -p "kill-session #S? (y/n)" kill-session
      bind C-u command-prompt -p "Session to merge with: " \
         "run-shell 'yes | head -n #{session_windows} | xargs -I {} -n 1 tmux movew -t %%'"
      bind d detach
      bind D if -F '#{session_many_attached}' \
          'confirm-before -p "Detach other clients? (y/n)" "detach -a"' \
          'display "Session has only 1 client attached"'
      bind C-s if -F '#{s/off//:status}' 'set status off' 'set status on'
      bind m setw monitor-activity \; display-message 'Monitor window activity [#{?monitor-activity,ON,OFF}]'
      bind M if -F '#{monitor-silence}' \
          'setw monitor-silence 0 ; display-message "Monitor window silence [OFF]"' \
          'command-prompt -p "Monitor silence: interval (s)" "setw monitor-silence %%"'
      set -g visual-activity on
      set -g @copy_use_osc52_fallback on
      bind p paste-buffer
      bind C-p choose-buffer
      bind -n M-Up copy-mode
      bind -T copy-mode-vi M-Up              send-keys -X scroll-up
      bind -T copy-mode-vi M-Down            send-keys -X scroll-down
      bind -T copy-mode-vi M-PageUp          send-keys -X halfpage-up
      bind -T copy-mode-vi M-PageDown        send-keys -X halfpage-down
      bind -T copy-mode-vi PageDown          send-keys -X page-down
      bind -T copy-mode-vi PageUp            send-keys -X page-up
      bind -T copy-mode-vi WheelUpPane       select-pane \; send-keys -X -N 2 scroll-up
      bind -T copy-mode-vi WheelDownPane     select-pane \; send-keys -X -N 2 scroll-down
      if -b "command -v reattach-to-user-namespace > /dev/null 2>&1" \
          "run 'tmux set -g default-command \"exec $(tmux show -gv default-shell) 2>/dev/null & reattach-to-user-namespace -l $(tmux show -gv default-shell)\"'"
      yank="~/.tmux/yank.sh"
      bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "$yank"
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "$yank"
      bind -T copy-mode-vi Y send-keys -X copy-line \;\
          run "tmux save-buffer - | $yank"
      bind-key -T copy-mode-vi D send-keys -X copy-end-of-line \;\
          run "tmux save-buffer - | $yank"
      bind -T copy-mode-vi C-j send-keys -X copy-pipe-and-cancel "$yank"
      bind-key -T copy-mode-vi A send-keys -X append-selection-and-cancel \;\
          run "tmux save-buffer - | $yank"
      bind -T copy-mode-vi MouseDragEnd1Pane \
          send-keys -X copy-pipe "$yank"
      bind -T copy-mode-vi MouseDown1Pane select-pane \;\
         send-keys -X clear-selection
   '';
    plugins = with pkgs.tmuxPlugins; [
      sensible
		  yank
      weather
      tmux-fzf
      resurrect
      prefix-highlight
      battery
      sysstat
      copycat
      {
        plugin = sidebar;
        extraConfig = ''
          set -g @sidebar-tree 't'
          set -g @sidebar-tree-focus 'T'
          set -g @sidebar-tree-command 'tree -C'
        '';
      }
      {
        plugin = open;
        extraConfig = ''
          set -g @open-S 'https://www.google.com/search?q='
        '';
      }
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-plugins "battery cpu-usage ram-usage git network-bandwidth weather time"
          set -g @dracula-show-battery true
          set -g @dracula-show-powerline true
          set -g @dracula-show-flags true
          set -g @dracula-refresh-rate 10
          set -g @dracula-show-empty-plugins false
          set -g @dracula-left-icon-padding 1
          set -g @dracula-border-contrast true
          set -g @dracula-network-bandwidth eth0
          set -g @dracula-network-bandwidth-interval 0
          set -g @dracula-network-bandwidth-show-interface true
          set -g @dracula-fixed-location "Los Angeles, CA"
        '';
      }
    ];
  };
}

