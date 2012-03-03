all: activity.min.js

activity.min.js: activity.js
	uglifyjs ./lib/activity.js > ./lib/activity.min.js

activity.js: ./lib/activity.coffee
	coffee -c ./lib/activity.coffee
