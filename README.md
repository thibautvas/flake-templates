# flake-templates

## Quick start

```bash
nix flake init -t github:thibautvas/flake-templates
# resp. #apps, #devshells, #python
```

## Git and flake init

```bash
nix run github:thibautvas/flake-templates
# resp. #apps, #devshells, #python
```

## Special case: immutable python .venv

```bash
nix build github:thibautvas/flake-templates/ds#venv
# branch ds for data science packages
```
