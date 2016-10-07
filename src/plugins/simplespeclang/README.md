- infos = Information about the simplespeclang plugin is in keys below
- infos/author = Markus Raab <markus@libelektra.org>
- infos/licence = BSD
- infos/needs =
- infos/provides = storage
- infos/recommends =
- infos/placements = getstorage setstorage
- infos/status = maintained specific nodep preview experimental difficult unfinished old concept
- infos/metadata =
- infos/description =

## Introduction ##

See [the validation tutorial](/doc/tutorials/validation.md) for introduction.
This plugin provides a conceptual simplistic specification language.

It currently supports to specify:

- structure (which keys are allowed)
- enums (which values are allowed)

## Purpose

The plugin demonstrates how simple a configuration specification can be within the Elektra framework.
It is conceptual and mainly for educational usage.
You can base your plugins 

## Configuration

- /keyword/enum, default "enum": used as keywords for enum definitions.
- /keyword/assign, default "=": used as keywords for assignment.
- /path, default "default.ssl": used as path for `kdb mount-spec`


## Usage ##

First you need to mount the plugin to spec, e.g.:

    kdb mount myspec.ssl spec/test simplespeclang

Then you can write your specification (with default keywords):

    cat << HERE > `kdb file spec/test`
    enum key = value1 value2 value3
    enum key2 = value1 value2
    HERE

And finally you need a specification mount, so that all necessary
plugins are present (in this case

    kdb spec-mount /test

Also make sure that `spec` is mounted as global plugin:

    kdb global-mount

Then you are only able to write valid keys:

    kdb set /test/key value1
    kdb set /test/key2 value3 # rejected, no value3 for key2
    kdb set /test/something else # rejected, no key something
