ExUnitEmacs
===========

ExUnit + Emacs integration.

### Emacs Setup

You must be running the Emacs server for this to be able to drive the editor. To
start the server, type `M-x server-start` in Emacs.

## Formatter

Currently the only thing this offers is a simple integration that will
toggle your Emacs modeline colors based on suite success/failure.

Note: This implementation is inspired by
[Guard](https://github.com/guard/guard)'s `Guard::Notifier::Emacs`.

In combination with
[Guard Shell](https://github.com/guard/guard-shell) (or a similar
executable) this can be used to continually test a project in the background with
feedback to your editor.

To add the formatter, pass it as an option to `ExUnit.start`:

```elixir
ExUnit.start(%{formatters: [ExUnit.CLIFormatter, ExUnitEmacs.Formatter]})
```

Don't forget `ExUnit.CLIFormatter` if you want normal output as well.

## License

The MIT License (MIT)

Copyright (c) 2014 Bruce Williams

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
