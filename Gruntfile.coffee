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

  
  # Load the plugins
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  
  # Default task(s).
  grunt.registerTask 'default', ['coffee', 'uglify']