var gulp = require('gulp'),
    uglify = require('gulp-uglify'),
    coffee = require('gulp-coffee'),
    concat = require('gulp-concat'),
    gutil = require('gulp-util');


gulp.task('coffee', function()
{
  gulp.src('./src/**/*.coffee')
      .pipe(coffee({bare: true}).on('error', gutil.log))
      .pipe(gulp.dest('./bin/'));
});

gulp.task('min', function()
{
  gulp.src('./src/**/*.coffee')
      .pipe(coffee({bare: false}).on('error', gutil.log))
      .pipe(uglify())
      .pipe(concat('ms-dev-term.js'))
      .pipe(gulp.dest('.'));
});

gulp.task('dev', function() {
  gulp.watch('./src/**', ['coffee']);
});

gulp.task('default', ['dev']);