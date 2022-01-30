# Task

Use Task to construct external tasks (such as running scripts), access their properties or terminate them. Beware that some task properties are only set after the task has completed.

## Interface

```javascript
class Task implements Identifiable

  static int run(String path, Array arguments, Function callback)
  static void terminate(int identifier)

  property int status
  property String output
  property String error

  constructor Task Task(String path, Array arguments, Function callback)
  void terminate()

end
```

## Static Methods

- `run(String path, Array arguments, Function callback)` constructs a managed handler for a task and returns the identifier for the handler, for arguments see `new Task(...)`
- `terminate(int identifier)` terminates the managed handler for a task with the given identifier

## Instance Properties

- `status` read-only property for the termination status
- `output` read-only property for the standard output
- `error` read-only property for the standard error

## Constructor

- `new Task(String path, Array arguments, Function callback)` constructs a task that asynchronously executes an absolute path with the given arguments and returns the handler, you must keep a reference to the handler in order for your callback to get called, the callback function receives its handler as the only argument

## Instance Methods

- `terminate()` terminates the task immediately

## Example

```javascript
// Run uptime and log output
Task.run('/usr/bin/uptime', [], (task) => {
  console.log('Uptime:', task.output); // -> 'Uptime: 13:30  up  2:08, 3 users, load averages: 4,18 3,83 5,25'
});
```
