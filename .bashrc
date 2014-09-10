function cd { builtin cd "$@"; echo $(pwd) > $HOME/.pwd; }
test -f "$HOME/.pwd" || echo $(pwd) > $HOME/.pwd
cd "$(< $HOME/.pwd)"
EDITOR="/usr/bin/joe"
HISTTIMEFORMAT="%Y%m%d - %H:%M:%S "
alias dir="ls"
alias nocomments='sed -r "/^[[:space:]]*$/d;/^[[:space:]]*#/d;s/[[:space:]]+#.*//" '
alias sp2tb="perl -pi -e 's/ +/\t/g'"
alias unix2dos='perl -pi -e "s/\n/\r\n/"'
alias dos2unix='perl -pi -e "s/\r\n/\n/"'
alias striplf='paste -s -d " "'
alias epochs=sec2date
function sec2date { date -d "1970-01-01 $1 seconds GMT"; }
alias epochd=days2date
function days2date { date -d "1970-01-01 $1 days"; }
function doy { [ "$1" ] && d="-d $1"; date $d +%j; }
function now { date +%s; }
alias h2d='printf "%d" 0x${1}'
alias d2h='printf "%x" ${1}'
function d2a { perl -e "print chr '$1'"; }
function a2d { perl -e "print ord '$1'"; }
function a2h { IFS=''; for i in $@; do perl -e "foreach ( split //, '$i' ) { print sprintf('%x ', ord qq{\$_}) }"; done; unset IFS; }
function h2a { for i in $@; do if [ "$i" != "00" ]; then perl -e "print chr \$ARGV[0]" $(printf "%d" 0x${i}); fi; done; }
function db64 { perl -MMIME::Base64 -e 'print decode_base64($ARGV[0]||<STDIN>), "\n"' "$1"; }
function eb64 { perl -MMIME::Base64 -e 'print encode_base64($ARGV[0]||<STDIN>), "\n"' "$1"; }
function findonday {
	path=$1
	day=$2
	next=$(date -d "$day + 1 day")
	find "$path" -type f -newermt "$day" ! -newermt "$next"
}
function findnotonday {
	path=$1
	day=$2
	next=$(date -d "$day + 1 day")
	{ find "$path" -type f -newermt "$day" ! -newermt "$next" ; find "$path" -type f; } | sort | uniq -u
}
function highlight {
        IFS=$'\n'
        while read i; do
                echo -e $(env GREP="$1" perl -pi -e 's/\n/\\n/g;s/($ENV{GREP})/\\033[31m$1\\033[0m/g')
        done
        unset IFS
}
