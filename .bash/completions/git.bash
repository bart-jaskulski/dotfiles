#!/usr/bin/env bash

# Don't handle completion if it's already managed
if complete -p git &>/dev/null ; then
  return 0
fi

_git_bash_completion_found=false

# Load the first completion file found
for _comp_path in "${_git_bash_completion_paths[@]}" ; do
  if [ -r "$_comp_path" ] ; then
    _git_bash_completion_found=true
    source "$_comp_path"
    break
  fi
done

# Cleanup
if [[ "${_git_bash_completion_found}" == false ]]; then
  _log_warning "no completion files found - please try enabling the 'system' completion instead."
fi
unset _git_bash_completion_paths
unset _git_bash_completion_found
