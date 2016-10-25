# My First TODOs

## Development

Install dependencies with:

```sh
bundle install
```

Get code smells with:

```sh
rubycritic
```

### Testing

Run the test suite from [`./tests`](./tests) with:

```sh
rake test
```

## Usage

### Add TODOs

- Parameters:
  - Required:
    - `title`: the title of the TODO
    - `deadline`: when is the TODO due for
  - Optional:
    - `body`: contains more details about the TODO

```sh
# Example 1
ruby ./bin/todo add --title "A Title" --body "A body" --deadline 24/10/2016

# Example 2
ruby ./bin/todo add --title "Prepare halloween" --deadline 31/10/2016
```

### List TODOs

- Parameters:
  - Optional:
    - `sort`: sorts the list by an attribute (title, body, deadline, etc.)
    - `overdue`: filters the list in order to show only those TODOs which are overdue

```sh
# Example 1
ruby ./bin/todo ls

# Example 2
ruby ./bin/todo ls --sort title --overdue
```
