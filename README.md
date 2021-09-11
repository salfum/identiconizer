# Identiconizer

Command line utility for creating an png image from a given string.

## Requirements

`erlang, rebar3, elixir`

## Installation

1. Clone project
```
git clone git@github.com:salfum/identiconizer.git; cd identiconizer
```
2. Get dependencies and compile project
```
mix deps.get; mix compile; mix escript.build
```

## Usage example
```
./identiconizer salfum12
```
Creates a 250x250 png in the same directory

![Example image salfum12](images/salfum12.png "Example image salfum12")
#### Other examples in `/images` directory

## TODO:
- [ ] Add the ability to choose a grid size.
- [ ] Add the ability to force the color of the picture.
- [ ] Add other optional hashing algorithms like sha1, etc.
