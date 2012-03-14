all: idle.min.js

idle.min.js: idle.js
	uglifyjs ./lib/idle.js > ./lib/idle.min.js

idle.js: ./src/idle.coffee
	coffee -c -o ./src/idle.coffee ./lib/
