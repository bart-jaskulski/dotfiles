#!/usr/bin/env bash

function _command_exists ()
{
  # _about 'checks for existence of a command'
  # _param '1: command to check'
  # _param '2: (optional) log message to include when command not found'
  # _example '$ _command_exists ls && echo exists'
  # _group 'lib'
  local msg="${2:-Command '$1' does not exist!}"
  type "$1" &> /dev/null || (_log_warning "$msg" && return 1) ;
}

_is_function ()
{
    # _about 'sets $? to true if parameter is the name of a function'
    # _param '1: name of alleged function'
    # _group 'lib'
    [ -n "$(LANG=C type -t $1 2>/dev/null | grep 'function')" ]
}

_bash-it-array-contains-element() {
  local e
  for e in "${@:2}"; do
    [[ "$e" == "$1" ]] && return 0
  done
  return 1
}

function safe_append_prompt_command {
	local prompt_re

	if [ "${__bp_imported}" == "defined" ]; then
		# We are using bash-preexec
		if ! __check_precmd_conflict "${1}"; then
			precmd_functions+=("${1}")
		fi
	else
		# Set OS dependent exact match regular expression
		if [[ ${OSTYPE} == darwin* ]]; then
			# macOS
			prompt_re="[[:<:]]${1}[[:>:]]"
		else
			# Linux, FreeBSD, etc.
			prompt_re="\<${1}\>"
		fi

		if [[ ${PROMPT_COMMAND} =~ ${prompt_re} ]]; then
			return
		elif [[ -z ${PROMPT_COMMAND} ]]; then
			PROMPT_COMMAND="${1}"
		else
			PROMPT_COMMAND="${1};${PROMPT_COMMAND}"
		fi
	fi
}
