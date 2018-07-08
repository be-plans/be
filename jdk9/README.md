# Java JDK9

## Description

This package contains the Java JDK 9 to compile java applications.

Include this as a dependency in your own plan, so you can build your applications / jar files.

Couple it with the `lilian/jre9` package for running your app (if necessary)

## Usage

Your `plan.sh` dependencies will look similar to this:

```
pkg_deps=(
  lilian/jre9
)
pkg_build_deps=(
  lilian/jdk9
)
```

Build your application with:

```
do_build() {
  javac ...
}
```

Then, from your own `plan.sh` run hook, you can `exec java ...` to run your application (requires `lilian/jre9`).
