# Refactor TODOs

## Setup

Run `$ bundle install`

## Get code smells

Run `$ rubycritic`

## Run Tests

```sh
$ rake test
```

## Add TODOs

- Parameters:
  - Required:
    - **title:** the title of the TODO
    - **deadline:** when is the TODO due for
  - Optional:
    - **body:** contains more details about the TODO

```sh
$ ./bin/todo add --title "A Title" [--body "A body"] --deadline 24/10/2016
```

## List TODOs

- Parameters:
  - Optional:
    - **sort:** sorts the list by an attribute (title, body, deadline, etc.)
    - **overdue:** filters the list in order to show only those TODOs which are overdue

```sh
$ ./bin/todo ls [--sort title] [--overdue]
```
