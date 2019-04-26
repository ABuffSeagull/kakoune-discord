declare-option -hidden str discord_fifo

define-command -hidden discord-fifo-send -params 1 %{ nop %sh{
    { echo "$1" > "$kak_opt_discord_fifo"; } >/dev/null 2>&1 </dev/null &
} }

define-command discord-presence-enable \
    -docstring "Enable Discord rich presence for this kakoune session" %{
    evaluate-commands %sh{
        if [ -z "$kak_opt_discord_fifo" ] && [ "$(pidof Discord)" ]; then
            fifo=${TMPDIR:-/tmp}/kakoune/discord
            if [ ! -p "$fifo" ]; then
                mkfifo "$fifo"
                kakoune-discord "$fifo" >/dev/null 2>&1 </dev/null &
            fi
            cat<<EOF
set-option global discord_fifo $fifo
discord-fifo-send '+'

hook global -group discord FocusIn .* %{ discord-fifo-send %reg{%} }
hook global -group discord WinDisplay .* %{ discord-fifo-send %reg{%} }
hook global -group discord KakEnd .* %{ discord-fifo-send '-' }

define-command discord-presence-disable \
    -docstring "Disable Discord rich presence for this kakoune session" %{
    discord-fifo-send '-'
    unset-option global discord_fifo
    remove-hooks global discord
}
EOF
        fi
    }
}
