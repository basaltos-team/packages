# packages

Packaging repository for BasaltOS pacman packages.

## Owns

- PKGBUILDs for `basalt-*`.
- Package QA policy.
- Clean chroot build scripts.
- Package signing inputs.
- Package promotion metadata before it is handed to `repo-manifests/`.

## Planned Packages

- `basalt`
- `basalt-base`
- `basalt-branding`
- `basalt-dracut-hooks`
- `basalt-keyring`
- `basalt-mirrorlist`

## Planned Layout

```text
packages/
|-- packages/
|   |-- basalt/
|   |   |-- PKGBUILD
|   |   `-- basalt.install
|   |-- basalt-base/
|   |-- basalt-branding/
|   |-- basalt-dracut-hooks/
|   |   `-- files/usr/share/libalpm/hooks/70-basalt-dracut.hook
|   |-- basalt-keyring/
|   `-- basalt-mirrorlist/
|-- policy/
|   |-- package-naming.md
|   |-- signing.md
|   |-- dependencies.md
|   `-- hooks.md
|-- scripts/
|   |-- build-one
|   |-- build-all
|   |-- namcap-all
|   |-- sign-package
|   `-- generate-repo
|-- tests/
|   |-- install-clean-container.sh
|   |-- hook-order.sh
|   `-- keyring-import.sh
`-- .ci/
    |-- package.yml
    `-- promote.yml
```

## Contracts

- Consumes versioned Basalt release artifacts from `basalt/`.
- Emits signed `*.pkg.tar.zst` packages and build logs.
- Does not hand-edit published repo metadata. That is owned by `repo-manifests/`.
