# flake-templates

## Quick start

`nix flake init -t github:thibautvas/flake-templates#python`

## Build python `.venv`

`nix build --out-link .venv github:thibautvas/flake-templates?dir=templates/python-ds`

## Project structure

```text
.
├── .gitignore
├── README.md
├── flake.lock
├── flake.nix
└── templates
    ├── default
    │   └── flake.nix
    ├── devshells
    │   └── flake.nix
    ├── packages
    │   └── flake.nix
    ├── python
    │   ├── .gitignore
    │   ├── flake.lock
    │   ├── flake.nix
    │   ├── pyproject.toml
    │   ├── README.md
    │   └── uv.lock
    └── python-ds
        ├── .gitignore
        ├── flake.lock
        ├── flake.nix
        ├── pyproject.toml
        ├── README.md
        └── uv.lock

7 directories, 19 files
```
