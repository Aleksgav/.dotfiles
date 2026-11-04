# zj-notify — long-command alerts for zellij (loaded by sheldon, see sheldon/plugins.toml)
#
# A command that ran >= 10s and finished in a zellij pane you're not looking at
# -> bell (zjstatus tab marker) + zjstatus message + swaync popup, via ./zj-notify.
# Skips Ctrl-C'd commands (exit 130) and interactive programs (first word only).

zmodload zsh/datetime
autoload -Uz add-zsh-hook

# the notifier script lives next to this file
typeset -g _zj_done_notifier=${${(%):-%x}:A:h}/zj-notify

_zj_done_preexec() { _zj_done_start=$EPOCHSECONDS; _zj_done_cmd=$1 }
_zj_done_precmd() {
  local st=$?
  [[ -n $_zj_done_start ]] || return
  local dur=$(( EPOCHSECONDS - _zj_done_start ))
  unset _zj_done_start
  (( dur >= 10 && st != 130 )) || return
  case ${${(z)_zj_done_cmd}[1]} in
    nvim|vim|n|nz|ng|nv|nnv|fng|claude|lazygit|less|man|zellij|htop|btop|top|ssh|fzf) return ;;
  esac
  local title='✔ done'
  (( st )) && title="✘ exit $st"
  "$_zj_done_notifier" --bell "$title" "$_zj_done_cmd (${dur}s)"
}
add-zsh-hook preexec _zj_done_preexec
add-zsh-hook precmd _zj_done_precmd
