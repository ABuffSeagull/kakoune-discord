declare-option -hidden str discord_fifo ""

hook global KakBegin .* %{
	evaluate-commands %sh{
		if [[ -z $TMPDIR ]]; then TMPDIR=/tmp; fi
		mkfifo "$TMPDIR/kakoune/discord"
		echo "set-option global discord_fifo $TMPDIR/kakoune/discord"
	}
	nop %sh{ { kakoune-discord "$kak_opt_discord_fifo"; } &> /dev/null < /dev/null & }
}

hook global WinDisplay .* %{
	nop %sh{ { echo $kak_reg_percent > "$kak_opt_discord_fifo"; } &> /dev/null < /dev/null & }
}

hook global KakEnd .* %{
	nop %sh{
		echo 'exit' > "$kak_opt_discord_fifo"
		rm "$kak_opt_discord_fifo"
	}
}
