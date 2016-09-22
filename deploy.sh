#!/usr/bin/env bash
set -e # halt script on error

bundle exec jekyll build
# bundle exec travis-lint
# bundle exec htmlproof ${HTML_FOLDER} --disable-external
HTML_FOLDER=$(pwd)/_site/

echo "\${HTML_FOLDER}: [${HTML_FOLDER}]"

if [ -n ${HTML_FOLDER} ] && [[ ${HTML_FOLDER} =~ ^(/[^/ ]*)+/?$ ]]; then
    cd ${HTML_FOLDER}
else
    echo "\${HTML_FOLDER} not set. Exiting."
    exit 1
fi

# config
git config --global user.email "admin@incidentnormal.uk"
git config --global user.name "IncidentNormal"

# deploy
git init
#git remote add origin git@github.com:IncidentNormal/incidentnormal.github.io.git
git add --all
git commit -m "Deploy to GitHub Pages @ ($(date))"
#git push --force --quiet "https://${GH_TOKEN}@github.com/${GH_REF}" master:gh-pages
git push origin master
