# \_sources

This directory contains the outputs of `nvfetcher`:

```bash
_sources
├── generated.json
└── generated.nix
```

## How to fetch latest sources

Change directory to the root of `nichijou` project, then run

```bash
nvfetcher
```

Or, if you haven't install `nvfetcher`, run

```bash
nix run github:berberman/nvfetcher
```

The latest versions and sources will be stored in `generated.json` and `generated.nix`.

## How to use sources

```nix
let
    sources = pkgs.callPackage (projectRoot + /_sources/generated.nix) {};
in {
    # Define your package or anything else here...
}
```

## How to add a new source

The configuration of `nvfetcher` locates at `nvfetcher.toml`. Please refer to [berberman/nvfetcher](https://github.com/berberman/nvfetcher) for further details.
