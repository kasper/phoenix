'use strict';

module.exports = function (grunt) {

  /* Task configuration */

  grunt.initConfig({

    pkg: grunt.file.readJSON('package.json'),

    uglify: {

      library: {
        files: {
          'Phoenix/<%= pkg.name %>.min.js': 'Phoenix/<%= pkg.name %>.js'
        }
      }
    }
  });

  /* Load tasks */

  grunt.loadNpmTasks('grunt-contrib-uglify');

  /* Register tasks */

  grunt.registerTask('build', [ 'uglify' ]);
  grunt.registerTask('default', [ 'build' ]);
}
