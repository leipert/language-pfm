var path = require('path'),
  CSON = require('season'),
  _ = require('lodash'),
  fs = require('fs'),
  gulp = require('gulp');

var rename = require('gulp-rename');

gulp.task('default', ['build.grammars'])

gulp.task('copyFiles', function() {
  return gulp.src('**/gfm.cson')
  .pipe(rename({
    basename: 'pfm'
  }))
  .pipe(gulp.dest('.'));
});

gulp.task('build.grammars', ['copyFiles'], function(cb) {

  var grammarPath = path.resolve(__dirname, 'grammars', 'pfm.cson');

  var gfm = CSON.readFileSync(grammarPath);

  var pfm = CSON.readFileSync(path.resolve(__dirname, 'src', 'grammars', 'pfm.cson'));

  gfm.name = pfm.name;
  gfm.patterns = _(pfm.patterns)
  .union(gfm.patterns)
  .value();

  var string = CSON.stringify(gfm).replace(/"(\^#\{\d\}\\\\s\*)"/g, "'$1'");
  fs.writeFileSync(grammarPath, string);

  cb();

});
