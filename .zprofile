export UUID=$(uuidgen)
$(/usr/local/bin/emacs --daemon=$UUID > /dev/null 2>&1 &)
