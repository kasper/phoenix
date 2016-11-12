'use strict';

module.exports = function (grunt) {

  /* Task configuration */

  grunt.initConfig({

    pkg: grunt.file.readJSON('package.json'),

    clean: {
      build: [ '.grunt/', 'Phoenix/<%= pkg.name %>.js' ]
    },

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
    },

    jshint: {
      src: [ 'Gruntfile.js', 'library/src/**/*.js' ],
      options: {
        jshintrc: 'jshint.json'
      }
    },

    jscs: {
      src: [ 'Gruntfile.js', 'library/src/**/*.js' ],
      options: {
        config: 'jscs.json'
      }
    }
  });

  /* Load tasks */

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-jscs');

  /* Register tasks */

  grunt.registerTask('test', [ 'jshint', 'jscs' ]);
  grunt.registerTask('build', [ 'concat', 'uglify' ]);
  grunt.registerTask('default', [ 'clean', 'test', 'build' ]);
}
