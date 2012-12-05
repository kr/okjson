#!/bin/bash -e

fail() {
	echo >&2 "$@"
	exit 1
}

if ! diff -q <(git show HEAD:okjson.rb) <(git show :okjson.rb) >/dev/null 2>&1
then
	old=`(git show HEAD:okjson.rb ; echo 'puts OkJson::Upstream')|ruby`
	new=`(git show     :okjson.rb ; echo 'puts OkJson::Upstream')|ruby`
	test "$old" || fail empty old tag
	test "$new" || fail empty new tag
	test "$old" == "$new" && fail you forgot to update the tag
fi
