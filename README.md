# C++ development tools

## Usage

Init a new git repository:
```sh
curl https://raw.githubusercontent.com/ict-project/libict-dev-tools/refs/heads/main/init-new-git-repo.sh | bash
```

Update files in existing git repository:
```sh
./libict-dev-tools/update-files.sh
```

## Building instructions

```sh
make # Build library
make test # Execute all tests
make package # Create library package
make package_source  # Create source package
```