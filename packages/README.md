# Package Plan

Package work starts after `basalt validate` and `basalt diff` exist.

Initial packages:

- `basalt`: Rust CLI/TUI binary.
- `basalt-base`: BasaltOS base metapackage.
- `basalt-branding`: identity files and shell/fastfetch defaults.
- `basalt-keyring`: pacman signing keys.
- `basalt-dracut-hooks`: ALPM hooks for dracut rebuilds.
- `basalt-mirrorlist`: repository mirror configuration.

