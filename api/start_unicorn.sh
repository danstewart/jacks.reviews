#!/usr/bin/env bash
env=$1
[[ -z $env ]] && env='production'
[[ $env == 'dev' ]] && env='development'
[[ $env == 'prod' ]] && env='production'

if [[ $env != 'production' && $env != 'development' && $env != 'test' ]]; then
	echo 'Invalid env provided: must be production, development or test'
	exit 1
fi

pidfile='./shared/pids/unicorn.pid'
[[ -f $pidfile ]] && pid=$(cat ./shared/pids/unicorn.pid)

if [[ -n $pid ]]; then
	kill -0 $pid
	[[ $? == 0 ]] && kill -9 $pid
fi

RAILS_ENV=$env rbenv exec bundle exec unicorn_rails -c ./config/unicorn.rb -D

if [[ $? == 0 ]]; then
	echo "Successfully started unicorn in $env mode"
fi
