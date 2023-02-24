# changelog

A tool help generate CHANGELOG.md from git.

## Installation

```
go install github.com/lack-io/changelog
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
