var path = require('path'),
  CSON = require('season'),
  _ = require('lodash'),
  fs = require('fs'),
  glob = require('glob'),
  gulp = require('gulp');

var languages = require('./src/languages.js');
var addPatternsToRepository = require('./src/addPatterns.js');
var rename = require('gulp-rename');
var replace = require('gulp-replace');

gulp.task('default', ['build.grammars', 'fixTests'])

gulp.task('copyFiles', function() {
  return gulp.src('**/gfm.cson')
    .pipe(rename({
      basename: 'pfm'
    }))
    .pipe(gulp.dest('.'));
});

gulp.task('fixTests', function() {
  return gulp.src('spec/gfm-spec.coffee')
    .pipe(replace(/(it "tokenizes mentions")/g, "x$1"))
    .pipe(replace(/(it "tokenizes ([*_]{3})bold italic\2 text")/g,"x$1"))
    .pipe(replace(/(it "tokenizes ([*_]{2})bold\2 text")/g,"x$1"))
    .pipe(replace(/(it "tokenizes ([*_]{1})italic\2 text")/g,"x$1"))
    .pipe(replace('activatePackage("language-gfm")', 'activatePackage("language-pfm")'))
    .pipe(rename({
      basename: 'gfm-fixed-spec'
    }))
    .pipe(gulp.dest('spec/'))
})

gulp.task('build.grammars', ['copyFiles'], function(cb) {

  var grammarPath = path.resolve(__dirname, 'grammars', 'pfm.cson');

  var gfm = CSON.readFileSync(grammarPath);

  var pfm = CSON.readFileSync(path.resolve(__dirname, 'src', 'grammars', 'pfm.cson'));

  var repositories = _.map(glob.sync(path.resolve(__dirname, 'src', 'repositories', '**', '*.cson')), function(r) {
    return CSON.readFileSync(r);
  });

  repositories.push(
    createRepository('code', languages.inline, languages.block)
  );

  _.forEach(repositories, function(r) {
    _.forEach(r.repository, function(repo, key) {
      if (pfm.repository.hasOwnProperty[key]) {
        console.warn('repository ' + key + ' already defined, overwriting');
      }
      pfm.repository[key] = repo;
    });
    _.forEach(r['extend-repository-patterns'], function(patterns, key) {
      if (_.contains(_.keys(pfm.repository), key)) {

        pfm.repository[key].patterns = _.union(
          pfm.repository[key].patterns,
          patterns
        );
      }
    });
  });

  var ret = _.extend({}, gfm);

  ret.name = pfm.name;

  var repos = [
    'block-no-emphasis',
    'inline-no-emphasis',
    'single-line',
    'emphasis-inline',
    'emphasis-block'
    ];

  ret.patterns = _(generateInclude(repos))
    .union(pfm.patterns)
    .union(ret.patterns)
    .value();

  var headingRepository = {
    patterns: _(ret.patterns)
      .filter(isHeading)
      .map(function(h) {
        h.patterns = generateInclude(['inline']);
        return h;
      })
      .value()
  };

  var codeRepository = {
    patterns: _(languages)
      .value()
  }

  ret.repository = pfm.repository;
  ret.repository.headings = headingRepository;

  ret.patterns = _(ret.patterns)
    .reject(isHeading)
    .value();

  ret = addPatternsToRepository(ret);

  ret.fileTypes.push('pmd');
  ret.fileTypes.push('p.md')

  ret.repository = _.chain(ret.repository)
    .mapValues(function(r, key){
      r.patterns = _.chain(r.patterns)
        .map(function(x){
            x.order = x.order ? x.order : 1000;
            return x;
        })
        .sortBy('order')
        .map(function(x){
          delete x.order;
          return x;
        })
        .value();
      return r;
    })
    .value();

  var string = CSON.stringify(ret)
    .replace(/'/g, "\\'")
    .replace(/([^\\])"/g, "$1'")
    .replace(/\\"/g, '"');

  fs.writeFileSync(grammarPath, string);

  cb();

});

function generateInclude(repos) {
  return _.map(repos, function(repo) {
    return {
      include: '#' + repo
    }
  })
}

function isHeading(value, key) {

  return value.hasOwnProperty('name') &&
    _.startsWith(value.name, 'markup.heading.heading');

}

function startsWith(filter) {

  return function(value) {

    return value.hasOwnProperty('name') &&
      _.startsWith(value.name, filter);

  }

}

function createRepository(name, inline, block) {
  var r = {
    'extend-repository-patterns': {
      'inline-no-emphasis': [],
      'block-no-emphasis': []
    },
    repository: {}
  }
  if (!_.isEmpty(inline)) {
    r['extend-repository-patterns']['inline-no-emphasis']
      .push({
        'include': '#' + name + '-inline'
      });
    r.repository[name + '-inline'] = {
      patterns: inline
    };

  }
  if (!_.isEmpty(block)) {
    r['extend-repository-patterns']['block-no-emphasis']
      .push({
        'include': '#' + name + '-block'
      });
    r.repository[name + '-block'] = {
      patterns: block
    };

  }
  return r;
}
