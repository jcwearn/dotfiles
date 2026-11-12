export UUID=$(uuidgen)
$(/opt/homebrew/opt/emacs/bin/emacs --daemon=$UUID > /dev/null 2>&1 &)
