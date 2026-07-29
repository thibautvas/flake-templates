# flake-templates

## Quick start

```bash
nix flake init -t github:thibautvas/flake-templates
# resp. #apps, #devshells, #python
```

## Build immutable python `.venv`

```bash
nix build --out-link .venv github:thibautvas/flake-templates/ds?dir=templates/python
# branch ds for data science packages
```

## Project structure

```text
.
├── .gitignore
├── README.md
├── flake.lock
├── flake.nix
└── templates
    ├── apps
    │   └── flake.nix
    ├── default
    │   └── flake.nix
    ├── devshells
    │   └── flake.nix
    └── python
        ├── .gitignore
        ├── README.md
        ├── .envrc
        ├── flake.lock
        ├── flake.nix
        ├── pyproject.toml
        └── uv.lock

6 directories, 14 files
```
