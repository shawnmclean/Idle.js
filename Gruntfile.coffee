module.exports = (grunt) ->
  
  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    uglify:
      options:
        banner: "/*! <%= pkg.name %>, copyright <%= grunt.template.today(\"yyyy-mm-dd\") %>, Shawn Mclean*/\n"
      build:
        src: "build/idle.js"
        dest: "build/idle.min.js"
    coffee:
      compile:
        files:
          'build/idle.js':'src/*.coffee'
          'test/tests.js':'test/*.coffee'
    qunit:
      all: ['test/*.htm']

  
  # Load the plugins
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-qunit'
  
  # Default task(s).
  grunt.registerTask 'build', ['coffee', 'uglify', 'qunit']
  grunt.registerTask 'default', 'build'
