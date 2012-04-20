all: idle.min.js test

test: ./test/tests.coffee
	coffee -c ./test/


idle.min.js: idle.js
	uglifyjs ./build/idle.js > ./build/idle.min.js

idle.js: ./src/idle.coffee
	coffee -c -o ./src/idle.coffee ./build/
