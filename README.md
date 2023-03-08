# changelog

A tool help generate CHANGELOG.md from git.

## Installation

```
bash -c "$(curl -fsSL https://raw.github.com/lack-io/changlog/master/install.sh)"
```

## Usage

### under target git repository

```
changelog --output CHANGELOG.md
```

### print logs

```
changelog --verbose
```

### print last logs

```
changelog --verbose --last
```

### fetch latest repository

```
changelog --fetch
```

### set target repository folder and target CHANGELOG.md path

```
changelog --source ~/gitrepo --output ~/gitrepo/CHANGELOG.md --fetch --verbose
```
