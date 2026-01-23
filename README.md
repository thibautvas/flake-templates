# flake-templates

## Quick start

```bash
nix flake init -t github:thibautvas/flake-templates#python
```

## Build python `.venv`

```bash
nix build --out-link .venv github:thibautvas/flake-templates?dir=templates/python-ds
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
    ├── python
    │   ├── .gitignore
    │   ├── README.md
    │   ├── .envrc
    │   ├── flake.lock
    │   ├── flake.nix
    │   ├── pyproject.toml
    │   └── uv.lock
    └── python-ds
        ├── .gitignore
        ├── README.md
        ├── .envrc
        ├── flake.lock
        ├── flake.nix
        ├── pyproject.toml
        └── uv.lock

7 directories, 21 files
```
