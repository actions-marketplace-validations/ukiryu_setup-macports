# Setup MacPorts

[![build](https://github.com/ukiryu/setup-macports/workflows/test.yml/badge.svg)](https://github.com/ukiryu/setup-macports/actions/workflows/test.yml)

This action installs and configures [MacPorts](https://www.macports.org/) on macOS runners.

## What's new

- Improved caching support with automatic cache key generation
- Support for fetching `macports/macports-ports` via GitHub API (no git dependency)
- Full TypeScript rewrite with comprehensive unit and integration tests
- Support for all current macOS versions: Sonoma (14), Sequoia (15), Tahoe (26)
- Support for both ARM64 (Apple Silicon) and Intel (x86_64) architectures

## Usage

### Basic usage

```yaml
steps:
  - uses: ukiryu/setup-macports@v1
```

### Inputs

The following inputs can be specified as `with:` keys:

| Name | Description | Default |
|------|-------------|---------|
| `macports-version` | MacPorts version to install (e.g., `2.11.5`, `2.10.0`) | `2.11.5` |
| `installation-prefix` | Installation prefix (currently only `/opt/local` is supported) | `/opt/local` |
| `variants` | Global variants to configure. Use `+variant` to enable, `-variant` to disable. Space-separated. | `''` |
| `sources` | Custom port sources (one per line). First entry marked as `[default]` | `''` |
| `use-git-sources` | Fetch `macports/macports-ports` via GitHub API for local sources | `true` |
| `install-ports` | Ports to install after setup. Space-separated or JSON array | `''` |
| `prepend-path` | Add MacPorts to `PATH` | `true` |
| `verbose` | Enable verbose mode for port operations | `false` |
| `signature-check` | Verify package signatures during installation | `true` |
| `debug` | Enable debug logging | `false` |

### Outputs

| Name | Description |
|------|-------------|
| `version` | The MacPorts version installed |
| `prefix` | The installation prefix path |
| `package-url` | URL of the installer package used |
| `cache-key` | Cache key for this installation |

## Scenarios

### Install a specific version

```yaml
steps:
  - name: Setup MacPorts 2.10.0
    uses: ukiryu/setup-macports@v1
    with:
      macports-version: '2.10.0'
```

### Configure global variants

```yaml
steps:
  - name: Setup MacPorts with Aqua and Metal
    uses: ukiryu/setup-macports@v1
    with:
      variants: '+aqua +metal -x11'
```

### Install specific ports

```yaml
steps:
  - name: Setup MacPorts and install ports
    uses: ukiryu/setup-macports@v1
    with:
      install-ports: 'git curl wget'
```

### Install ports with variants

```yaml
steps:
  - name: Setup MacPorts with port variants
    uses: ukiryu/setup-macports@v1
    with:
      install-ports: >-
        [
          {"name":"db48","variants":"+tcl +universal -java"},
          {"name":"gmp","variants":"+native"},
          {"name":"curl"}
        ]
```

### Use rsync sources instead of git

```yaml
steps:
  - name: Setup MacPorts with rsync
    uses: ukiryu/setup-macports@v1
    with:
      use-git-sources: 'false'
```

### Use custom port sources

```yaml
steps:
  - name: Setup MacPorts with custom sources
    uses: ukiryu/setup-macports@v1
    with:
      sources: >-
        file:///path/to/local/ports [default]
        rsync://rsync.macports.org/macports/release/tarballs/ports.tar
```

### Caching

MacPorts supports caching via `actions/cache`. The cache key is automatically generated based on:
- macOS version
- Architecture
- MacPorts version
- Configuration (variants, sources)

```yaml
- name: Setup MacPorts
  uses: ukiryu/setup-macports@v1
  id: macports

- name: Cache MacPorts
  uses: actions/cache@v4
  with:
    path: /opt/local
    key: ${{ steps.macports.outputs.cache-key }}
```

### Recommended permissions

The action needs minimal permissions:

```yaml
permissions:
  contents: read
```

For installing ports or additional operations:

```yaml
permissions:
  contents: read
  packages: write  # if installing packages
```

## Platform Support

This action supports the following macOS runners:

| Runner | Version | Architecture |
|--------|---------|--------------|
| `macos-14` | Sonoma | ARM64 |
| `macos-15` | Sequoia | ARM64 |
| `macos-15-intel` | Sequoia | Intel x86_64 |
| `macos-26` | Tahoe | ARM64 |

## License

The scripts and documentation in this project are released under the [MIT License](LICENSE).

## Supporters

The original implementation was inspired by [melusina-org/setup-macports](https://github.com/melusina-org/setup-macports).
