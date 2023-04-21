export VIRTUAL_ENV_DISABLE_PROMPT=1
setopt PROMPT_SUBST
autoload -Uz vcs_info

precmd() { 
    vcs_info 
}

zstyle ':vcs_info:git:*' formats '%b'

# venv
function venv_part() {
	if [[ $(echo -n "$VIRTUAL_ENV" | wc -m) -ge 2 ]]; then
		echo "%F{159}`basename $VIRTUAL_ENV`%f${SEPARATOR}"
	fi
}

# git
function repo_status_part() {
    if [[ -n ${vcs_info_msg_0_} ]]
        then
        local REPO_STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
        if [[ -n $REPO_STATUS ]]
        then
            echo "${SEPARATOR}%F{214}${vcs_info_msg_0_}%f"
		else
            echo "${SEPARATOR}%F{255}${vcs_info_msg_0_}%f"
        fi
    fi
}

function easter_egg_part() {
    if [ $(seq 1000 | sort -R | head -1) -eq 420 ]; then
        echo "(42 72 75 68) "
    fi
}

#local SEPARATOR="%F{235}│%f"
local SEPARATOR="%F{235}  %f"
local VENV_PART='$(venv_part)'
local START_PART="%F{255}┍ %f"
local USERNAME_PART="%B%F{226}%n%f%b"
local HOSTNAME_PART="${SEPARATOR}%F{255}%m%f"
local WORKING_DIR_PART="${SEPARATOR}%F{255}%2d%f"
local REPO_STATUS_PART='$(repo_status_part)'
local TIME_PART="${SEPARATOR}%F{255}%*%f"
local EXIT_STATUS_PART="${SEPARATOR}%(?.%F{255}%?%f.%F{214}%?%f)"
local END_PART="%F{255}┕ %f"
local EASTER_EGG_PART='$(easter_egg_part)'

PROMPT="${START_PART}${VENV_PART}${USERNAME_PART}${HOSTNAME_PART}${WORKING_DIR_PART}${REPO_STATUS_PART}${TIME_PART}${EXIT_STATUS_PART}
${END_PART}${EASTER_EGG_PART}"
