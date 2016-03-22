module.exports = config:
  plugins:
    ng_templates:
      module: 'admin_console'
      relativePath: 'app/'
    babel:
      pattern: /\.es6/
      plugins: [ "transform-class-properties" ]
  files:
    javascripts:
      joinTo:
        'app.js': /^app/
        'libraries.js': [
          'vendor/jquery.js',
          'vendor/angular.js',
          'vendor/angular-resource.js',
          'vendor/router.es5.js',
          'vendor/chosen.jquery.js',
          'vendor/angular-chosen.js',
          'vendor/angular-flash.js',
          'vendor/angular-translate.js',
          'vendor/angular-translate-loader-static-files.js',
          'vendor/dirPagination.js',
          'vendor/chartist.js',
          'vendor/moment.min.js'
        ]
    stylesheets:
      joinTo:
        'app.css': /^app/
        'libraries.css': [
          'vendor/bootstrap.css',
          'vendor/chartist.min.css',
          'vendor/chosen.min.css'
        ]
    templates:
      joinTo:
        'templates.js': [
          /^app/
        ]
