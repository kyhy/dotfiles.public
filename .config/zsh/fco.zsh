__get-remote-url() {
  local url
  url=$(git config --get remote.upstream.url)
  if [[ -z "$url" ]]; then
    url=$(git config --get remote.origin.url)
  fi
  echo $url
}

__fh-checkout() {
  local url=$(__get-remote-url)
  if [[ -z "$url" ]]; then
    echo "$PWD is not a git repository"
    return
  fi

  local branchName=$1
  if [[ -n $branchName ]]; then
    git checkout $branchName
  else
    local tags local_branches remote_branches target
    # get local branch names and add yellow prefix "local" to branch names
    local_branches=$(
      git --no-pager branch \
        --sort=-committerdate \
        --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;33;1mlocal%09%1B[m%(refname:short)%(end)%(end)" \
      | sed '/^$/d') || return
    # get remote branch names and add blue prefix "remote" to branch names
    remote_branches=$(
      git --no-pager branch --remote \
        --sort=-committerdate \
        --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mremote%09%1B[m%(refname:short)%(end)%(end)" \
      | sed '/^$/d') || return
    # get tag names and add purple prefix "remote" to branch names
    tags=$(
      git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
    # open fzf and select branch name
    target=$(
      (echo "$local_branches"; echo "$remote_branches"; echo "$tags") |
      fzf --no-sort --no-hscroll --no-multi -n 2 \
          --ansi) || return
    git checkout $(awk '{print $2}' <<<"$target" )
  fi

}

