#!/usr/bin/env bash

set -o errexit
set -o nounset

yum groupinstall -y "Development Tools"
yum install -y ruby ruby-devel rubygems sqlite-devel rubygem-rake
gem install sqlite3-ruby

git clone https://github.com/sibprogrammer/owp.git

PROJECT=owp
cd $PROJECT
REVISION=`git show | egrep '^commit' | awk '{ print $2 }'`
echo $REVISION > revision

VERSION=`grep "PRODUCT_VERSION" config/environment.rb | sed -e 's/[^0-9.]//g'`
echo $VERSION > version

for TEXT_FILE in README INSTALL CHANGELOG; do
  mv $TEXT_FILE.md $TEXT_FILE
done

# remove extra markup for better readability
sed -i '/!\[/d' README
sed -i 's/^##\? //' README

# prepare database
rake db:migrate RAILS_ENV="production"

mkdir -p tmp log

# minimize distribution size
rm -rf build vendor/rails/railties/doc/guides vendor/rails/activerecord/test

rm -rf .git .gitignore .travis.yml

cp utils/hw-daemon/hw-daemon.ini.sample utils/hw-daemon/hw-daemon.ini

cd ..
