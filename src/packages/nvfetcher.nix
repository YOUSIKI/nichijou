# Generate nix sources expr for the latest version of packages.
# Export nvfetcher to packages and cache it to cachix & garnix.
{inputs', ...}:
inputs'.nvfetcher.packages.default or null
