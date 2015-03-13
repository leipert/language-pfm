var path = require('path'),
  CSON = require('season'),
  _ = require('lodash'),
  fs = require('fs'),
  gulp = require('gulp');

var replace = require('gulp-replace');
var rename = require('gulp-rename');

gulp.task('default', ['build.grammars', 'copyTests'])

gulp.task('copyFiles', function() {
  return gulp.src('**/gfm.cson')
  .pipe(replace('gfm', 'pfm'))
  .pipe(rename({
    basename: 'pfm'
  }))
  .pipe(gulp.dest('.'));
});

gulp.task('copyTests', function() {

  return gulp.src('**/gfm-spec.coffee')
  .pipe(replace('gfm', 'pfm'))
  .pipe(replace(/(it "tokenizes mentions")/g, "x$1"))
  .pipe(replace(/(it "tokenzies matches inside of headers")/g, "x$1"))
  .pipe(replace(/(it "tokenizies an :emoji:")/g, 'x$1'))
  .pipe(replace(/(it "tokenizes issue numbers")/g, 'x$1'))
  .pipe(replace(/(it "tokenizes > quoted text")/g, 'x$1'))
  .pipe(rename({
    basename: 'pfm-old-spec'
  }))
  .pipe(gulp.dest('.'));
});

gulp.task('build.grammars', ['copyFiles'], function(cb) {

  var grammarPath = path.resolve(__dirname, 'grammars', 'pfm.cson');

  var gfm = CSON.readFileSync(grammarPath);

  var pfm = CSON.readFileSync(path.resolve(__dirname, 'src', 'grammars', 'pfm.cson'));

  gfm.name = pfm.name;
  gfm.patterns = _(gfm.patterns)
  .union(pfm.patterns)
  .reject(function(x) {
    return x.name === 'string.emoji.pfm'
  })
  .reject(function(x) {
    return x.hasOwnProperty('captures') && x.captures.hasOwnProperty('1')
    && (x.captures['1'].name === 'variable.mention.pfm'
    || x.captures['1'].name === 'variable.issue.tag.pfm')
  })
  .value();

  var string = CSON.stringify(gfm).replace(/"/g, "'");
  fs.writeFileSync(grammarPath, string);

  cb();

});
