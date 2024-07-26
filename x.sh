#!/usr/bin/zsh
set -euo pipefail

purge() {
  rm -rf node_modules/.vite/ build/
}

xxx() {
  pnpm run dev
}

kg() {
  rm -rfv node_modules pnpm-lock.yaml
  cat > package.json <<EOL
{
  "private": true,
  "sideEffects": false,
  "type": "module",
  "scripts": {
    "build": "remix vite:build",
    "dev": "remix vite:dev --port 3000",
    "start": "remix-serve ./build/server/index.js"
  }
}
EOL

pnpm add '@remix-run/node'
pnpm add '@remix-run/react'
pnpm add '@remix-run/serve'
pnpm add 'isbot'
pnpm add 'react'
pnpm add 'react-dom'

pnpm add -D 'vite'
pnpm add -D '@remix-run/dev'
}

www() {
  inotifywait -mr -e close_write -e delete -e moved_to ./scratch.js \
    | while read ; do
      clear -x
      cl -b 27  -f 51 -o '------------------------------------------------'
      echo
      cat -n <(./scratch.js || :)
    done
  }

  _k=(${(ok)functions:#_*})
  _v=(${(oM)_k#[a-z]*})
  typeset -A _o
  _o=(${_v:^_k})

  eval 'zparseopts -D -E -F -a _a '${_v}

  [[ ${#_a} -eq 0  ]] && \
    paste -d ' ' <(print -l '\-'${(j:\n-:)_v}) <(print -l ${_k}) && exit

  _a=('$_o['${^_a#-}']')
  eval ${(F)_a}
  exit
