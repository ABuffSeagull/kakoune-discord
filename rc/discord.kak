echo -debug "Loaded plugin!"

hook global KakBegin .* %sh{
	mkfifo /tmp/kakoune/discord
}

hook global KakEnd %sh{
	rm /tmp/kakoune/
}
