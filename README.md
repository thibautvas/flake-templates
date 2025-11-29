# flake-templates

## Quick start

`nix flake init -t github:thibautvas/flake-templates#python`

## Build python `.venv`

`nix build --out-link .venv github:thibautvas/flake-templates?dir=templates/python-ds`

## Project structure

```text
.
├── .gitignore
├── flake.lock
├── flake.nix
├── README.md
└── templates
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

6 directories, 18 files
```
