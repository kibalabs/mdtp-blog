#!/bin/bash
set -e

# NOTE(krishan711): from https://github.com/docker-library/ghost/blob/master/5/debian/docker-entrypoint.sh

# allow the container to be started with `--user`
if [[ "$*" == node*current/index.js* ]] && [ "$(id -u)" = '0' ]; then
	find "$GHOST_CONTENT" \! -user node -exec chown node '{}' +
	exec gosu node "$BASH_SOURCE" "$@"
fi

if [[ "$*" == node*current/index.js* ]]; then
	baseDir="$GHOST_INSTALL/content.orig"
	for src in "$baseDir"/*/ "$baseDir"/themes/*; do
		src="${src%/}"
		target="$GHOST_CONTENT/${src#$baseDir/}"
		mkdir -p "$(dirname "$target")"
        # NOTE(krishan711): Changed this to always overwrite
		# if [ ! -e "$target" ]; then
        tar -cC "$(dirname "$src")" "$(basename "$src")" | tar -xC "$(dirname "$target")"
		# fi
	done
fi

exec "$@"
