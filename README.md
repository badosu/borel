Borel
=====

Borelian sets are formed by enumerable union, intersection or
 complement, of intervals.

**Borel** enables performing regular operations on intervals
 of any comparable class.

**Borel** borrows many of the ideas _(and code)_
 from the  **Intervals** [gem][1]. However it differs from Intervals in which
 it's aim is not on numerical precision and calculation, but on ease of use and
 solving some general interval related problems.

[1]: http://intervals.rubyforge.org

Install
-------

You may install it traditionally, tipically for interactive sessions:

    $ gem install borel

Or just put this somewhere on your application's `Gemfile`

```ruby
gem 'borel'
```

Usage
-----

### Initializing

An Interval can be initialized with an empty, one or two sized array
 (respectively for an _empty_, _degenerate_ or `Simple` interval), or
 an array of one or two sized arrays (for a `Multiple` interval).

```ruby
  Interval[]
  Interval[1]
  Interval[0,1]
  Interval[[0,1],[2,3],[5]]
```

Another way to initialize an Interval is by using the
 `#to_interval` method extension.

```ruby
  nil.to_interval     # -> Interval[]
  1.to_interval       # -> Interval[1]
  (1..2).to_interval  # -> Interval[1,2]
  (1...3).to_interval # -> Interval[1,2]
  [1,2].to_interval   # -> Interval[1,2]
```

The `Infinity` constant is available for specifying intervals
 with no upper or lower boundary.

```ruby
  Interval[-Infinity, 0]
  Interval[1, Infinity]
  Interval[-Infinity, Infinity]
```

### Properties

Some natural properties of intervals:

```ruby
  Interval[1,2].inf             # -> 1
  Interval[1,2].sup             # -> 2
  Interval[1].degenerate?       # -> true
  Interval[[0,1],[2,3]].simple? # -> false
  Interval[].empty?             # -> true
  Interval[1,5].include?(3.4)   # -> true
```

### Operations

* Complement

`#complement`, alias: `~`

```ruby
    ~Interval[0,5]             # -> Interval[[-Infinity, 0], [5, Infinity]]
```

* Union

`union`, aliases: `|`,`+`

```ruby
Interval[0,5] | Interval[-1,3] # -> Interval[-1,5]
```

* Intersection

`intersect`, aliases: `&`,`^`

```ruby
Interval[0,5] ^ Interval[-1,3] # -> Interval[0,3]
```

* Subtraction

`minus`, alias: `-`

```ruby
Interval[0,5] - Interval[-1,3] # -> Interval[3,5]
```

Generic Intervals
-----------------

You may use any **Comparable** class:

* String

```ruby
Interval['a','c'] ^ Interval['b','d'] # -> Interval['b','c']
Interval['a','c'] | Interval['b','d'] # -> Interval['a','d']
```

* Time

```ruby
def t(seconds)
  Time.now + seconds
end

Interval[t(1),t(5)] ^ Interval[t(3),t(7)] # -> Interval[t(3),t(5)]
Interval[t(1),t(2)] | Interval[t(3),t(4)] # -> Interval[[t(1),t(2)],[t(3),t(4)]]
```

Math Extensions
---------------

By requiring `borel/math_extensions` you are provided with some natural
math-related interval methods:

```ruby
require 'borel/math_extensions'

Interval[1,5].rand  # -> Random.new.rand 1..5
Interval[1,5].width # -> 5-1, only for simple intervals
```

It's supported only for `Numeric`, `Comparable` and arithmetic supported classes

Remarks
-------

* There is no distinction between _open_ and _closed_ intervals
* `complement` and `minus` operations, and also _Math Extensions_ have limited
support for non numeric-comparable classes

License
-------

(The MIT License)

Copyright (c) 2012 Amadeus Folego

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to
deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
