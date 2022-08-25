#!/bin/bash
exec find \( -path '*/.pc' -o -path '*/.svn' -o -path '*/.git' -o -path '*/.hg' \) -prune -o -type f -exec grep "$@" '{}' +
