function ls --description 'List contents of directory'
  exa --icons --group-directories-first -I "GPUCache" $argv
end
