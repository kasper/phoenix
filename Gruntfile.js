'use strict';

module.exports = function (grunt) {

  /* Task configuration */

  grunt.initConfig({

    pkg: grunt.file.readJSON('package.json'),

    concat: {

      library: {
        src: 'library/src/**/*.js',
        dest: 'Phoenix/<%= pkg.name %>.js',
        options: {
          separator: ';'
        }
      }
    },

    uglify: {

      library: {
        files: {
          'Phoenix/<%= pkg.name %>.min.js': 'Phoenix/<%= pkg.name %>.js'
        }
      }
    }
  });

  /* Load tasks */

  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');

  /* Register tasks */

  grunt.registerTask('build', [ 'concat', 'uglify' ]);
  grunt.registerTask('default', [ 'build' ]);
}
