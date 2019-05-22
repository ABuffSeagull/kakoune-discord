# Kakoune Discord
Discord presence for Kakoune!
Now you can show off to all your friends how ~~hipster~~cool your editor is :smirk:

![What it looks like](kak-discord.png)

## Installation

You should *really* use [plug.kak](https://github.com/andreyorst/plug.kak):
```
plug "abuffseagull/kakoune-discord" do %{ cargo install --path . --force } %{
  discord-presence-enable
}
```
And that's it!

If you would like some features or changes, issues and PRs are welcome.
