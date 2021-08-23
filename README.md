# fix-macos-internal-sdk

A silly CLI for replacing `macosx.internal` SDK settings in `.xcodeproj`
files with `macosx`. This is useful when building projects from opensource.apple.com

## Usage

```sh
fix-macosx-internal-sdk path/to/ld64.xcodeproj
```

## Installation

```sh
brew install keith/formulae/fix-macosx-internal-sdk
```

## Notes

- This can change more things in the `.xcodeproj` than just the SDK, if
  you're worried about that, check the project into version control
  before running this
- Some of Apple's open source projects use `.xcconfig` files and set the
  SDK there, this does not fix those. Run something like `rg
  macosx.internal` to verify all references you care about are gone.
