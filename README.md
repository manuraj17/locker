# Locker

A sample elixir app.

Locker is a simple application which enables you to create named _lockers_ with
a default password. You can then try unlock it and update it. Sample usage is
shown below.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `locker` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:locker, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/locker](https://hexdocs.pm/locker).


## Trying it out

`cd` into the directory and run `iex -S mix`

creating a box: `Locker.Supervisor.open_box(<box_name>, <password>)`
opening a box: `Locker.Client.unlock(<box_name>, <password>)`
update password of a box: `Locker.Client.reset(<box_name>, <old_password>,
<new_password>)`

## Sample output
```
iex(1)> Locker.Supervisor.open_box('foo', 'bar')
{:ok, #PID<0.140.0>}
iex(2)> Locker.Client.unlock('foo', 'bar')
:ok
iex(3)> Locker.Client.unlock('foo', 'foo')
:failed
iex(4)> Locker.Client.reset('foo', 'bar', 'foo')
:ok
iex(5)> Locker.Client.unlock('foo', 'foo')
:ok
```
