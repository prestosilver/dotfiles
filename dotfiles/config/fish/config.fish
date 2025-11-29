if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
end

set -gx BROWSER firefox 
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx BWP_COMMAND "waylandpaper"
set -gx BWP_DIR "$HOME/pix/wallpapers"
set -gx GEM_HOME "$XDG_DATA_HOME"/gem
set -gx GEM_SPEC_CACHE "$XDG_CACHE_HOME"/gem
set -gx GNUPGHOME "$XDG_DATA_HOME"/gnupg
set -gx GOPATH "$HOME/.local/go"
set -gx SDL_HOME "$HOME/.sdl/SDL2-2.0.12"
set -gx BWP_LOCK_IMAGE_OPTIONS "-resize 2560x1080!"
set -gx CM_HISTLENGTH 20
set -gx JAVA_HOME /usr/lib/jvm/java-8-openjdk/jre/
set -gx BWP_GEOMETRY "2256x1504"
set -gx MOZ_ENABLE_WAYLAND 1
set -gx ELECTRON_OZONE_PLATFORM_HINT wayland

thefuck --alias oops | source

alias spotifyd='spotifyd -u 21ndnpvlkdukezg7ht2mkcyay -P "pass spotify" --device-type speaker -d "Jorjes House" --on-song-change-hook "album-art"' 
alias vim='neovide'

function fish_right_prompt
  #intentionally left blank
end

thefuck --alias | source

#set -gx __done_notification_command "dunstify \$title \$message"
set -gx __done_min_cmd_duration 500 
