# https://github.com/blinks zsh theme
# see http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#SEC59
# inspired from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
#               http://forrst.com/posts/Oh_my_zsh_iTerm2_Nice_Colors_git_hg_suppo-1Ct
# needs Mercurial extension http://sjl.bitbucket.org/hg-prompt/
# see more for MQ pathces


ZSH_PROMPT_BASE_COLOR="%{%f%k%b%}"
ZSH_THEME_SVN_PROMPT_PREFIX=" %{%B%F{green}%}["
ZSH_THEME_REPO_NAME_COLOR="%{%B%F{blue}%}"
ZSH_THEME_SVN_PROMPT_SUFFIX="%{%B%F{blue}%}]"
ZSH_THEME_SVN_PROMPT_DIRTY="%{%F{red}%}!"
ZSH_THEME_SVN_PROMPT_ADDITIONS="%{%b%F{green}%}★"
ZSH_THEME_SVN_PROMPT_DELETIONS="%{%B%F{red}%}✖"
ZSH_THEME_SVN_PROMPT_MODIFICATIONS="%{%b%F{yellow}%}✎"
ZSH_THEME_SVN_PROMPT_REPLACEMENTS="%{%F{magenta}%}∿"
ZSH_THEME_SVN_PROMPT_UNTRACKED="%{%F{magenta}%}?"

# oh-my-git config
omg_prefix=" %{%B%F{green}%}[%{%f%k%b%}"
omg_suffix="%{%B%F{green}%}]%{%f%k%b%}"
display_git_symbol=false
display_git_current_action=left
print_unactive_flags_space=false
display_has_upstream=false
current_branch_color="%B%F{blue}"


function _prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    svn info >/dev/null 2>/dev/null && echo 'S' && return
    echo '○'
}

function colored_prompt_char() {
  # if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo "%{%F{blue}%}$(_prompt_char)%{%f%k%b%}"
  # else
  #  echo ' '
  # fi
}

function hg_prompt_info {
    hg prompt --angle-brackets "\
< %{%B%F{green}%}[%{%F{magenta}%}<branch>%{%f%k%b%}>\
< at %{%F{yellow}%}<tags|%{%f%k%b%}, %{%F{yellow}%}>%{%f%k%b%}>\
< %{%F{red}%}<status|modified|unknown>%{%f%k%b%}>\
< %{%F{red}%}<update>%{%f%k%b%}>\
%{%B%F{green}%}]%{%f%k%b%}" 2>/dev/null
}
chars='⚙ ♨ ♋ ㍖♫𝄢♬♪𝄆𝄇𝄈𝄐〖⦖〘〙》〰︴෴⸚⌁⌀⌖𝌁⿓⎃☢☣☠☤⚕'


local ret_status="%(?::%{$fg_bold[red]%}%S↑%s%? )"

function {
    if [[ -n "$SSH_CLIENT" ]]; then
        prompt_host="%{%f%k%b%}%{%B%F{green}%}%n%{%B%F{blue}%}@%{%B%F{cyan}%}%m%{%B%F{green}%} "
    else
        prompt_host=''
    fi
}

PROMPT='${ret_status}${prompt_host}%{%b%F{yellow}%}${PWD/#$HOME/~}%E%{%f%k%b%} $(colored_prompt_char) %(!.%F{red}❯❯❯%f.❯%f) %{%f%k%b%}'

RPROMPT='$(oh_my_git_info)$(hg_prompt_info)$(svn_prompt_info)$(battery_level_gauge)'
