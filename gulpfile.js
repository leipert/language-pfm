var path = require('path'),
  CSON = require('season'),
  _ = require('lodash'),
  fs = require('fs'),
  gulp = require('gulp');

languages = require('./src/languages.js');

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
  .pipe(replace('it "tokenizes mentions"', 'xit "tokenizes mentions"'))
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

  var ret = _.extend({}, gfm);

  ret.name = pfm.name;

  var repos = ['headings', 'inline', 'code'];

  ret.patterns = _(pfm.patterns)
  .union(ret.patterns)
  .reject(isCode)
  .union(generateInclude(repos))
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

  var inlineRepository = _.filter(ret.patterns, isInline);

  var codeRepository = {
    patterns: _(languages)
    .value()
  }

  //console.warn(_.pluck(codeRepository.patterns, 'name'))

  ret.repository = pfm.repository;
  ret.repository.headings = headingRepository;
  ret.repository['inline-non-emph'].patterns = _.union(ret.repository['inline-non-emph'].patterns,inlineRepository);
  console.warn(_.pluck(ret.repository['inline-non-emph'].patterns,'name'))
  ret.repository.code = codeRepository;

  ret.patterns = _(ret.patterns)
  .reject(isCode)
  .reject(isHeading)
  .reject(isInline)
  .reject(isIgnored)
  .reject(startsWith('markup.raw'))
  .value();

  ret.fileTypes.push('pmd');
  ret.fileTypes.push('p.md')

  var string = CSON.stringify(ret)
        .replace(/'/g,"\\'")
        .replace(/([^\\])"/g,"$1'")
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

function isIgnored(value, key){
  return value.hasOwnProperty('name') && (
  _.startsWith(value.name, 'markup.bold') ||
  _.startsWith(value.name, 'string.emoji.gfm') ||
  _.startsWith(value.name, 'markup.italic') ||
  _.startsWith(value.name, 'markup.strike')
)
}

function isInline(value, key) {
  return value.hasOwnProperty('name') && (
  value.name === 'link'  )
}

function isCode(value) {

  return value.hasOwnProperty('name') &&
  _.startsWith(value.name, 'markup.code');

}

function startsWith(filter) {

  return function(value) {

    return value.hasOwnProperty('name') &&
    _.startsWith(value.name, filter);

  }

}
