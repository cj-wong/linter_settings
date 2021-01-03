# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [0.1.2] - 2021-01-02
### Added
- Added [mypy] linter settings.

### Changed
- In [link_linter.sh], changed `link()` function such that:
    - Local variables are no longer in all caps (which should only be used for globals).
    - All tests use double brackets now.
    - All current linters can have settings in ~/.config (or `$XDG_CONFIG_HOME`), so `$2` in the function was removed.
    - The conditional is simplified such that the sym-link check and existence check are separated.

## [0.1.1] - 2020-11-03
### Added
- Added companion script [link_linter.sh] which automatically links linter setting files to their respective destinations.

## [0.1.0] - 2020-10-24
### Added
- Initial version

[link_linter.sh]: link_linter.sh
[mypy]: linters/mypy