CARGOENV="$HOME/.cargo/env"
if test -f "$CARGOENV"; then
. "$CARGOENV"
fi

if [ -e /home/k1ng/.nix-profile/etc/profile.d/nix.sh ]; then . /home/k1ng/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"
