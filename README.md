# flake-templates

## Quick start

```bash
nix flake init -t github:thibautvas/flake-templates
# resp. #apps, #devshells, #python
```

## Build immutable python `.venv`

```bash
nix build -o .venv github:thibautvas/flake-templates/ds?dir=templates/python
# branch ds for data science packages
```
