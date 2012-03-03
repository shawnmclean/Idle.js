all: idle.min.js

idle.min.js: idle.js
	uglifyjs ./lib/idle.js > ./lib/idle.min.js

idle.js: ./lib/idle.coffee
	coffee -c ./lib/idle.coffee
