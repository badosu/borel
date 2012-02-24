Borel
=====

Borelian sets are formed by enumerable union, intersection or
 complement, of intervals.

**Borel** enables performing regular operations on intervals
 of any comparable class.

**Borel** borrows many of the ideas _(and code)_
 from the  **Intervals** [gem][1].

[1]: http://intervals.rubyforge.org

Install
-------

You may install it traditionally, for interactive sessions:

    gem install borel

Or just put this somewhere on your application's `Gemfile`

    gem 'borel'

Usage
-----

### Initializing

An Interval can be initialized with an empty, one or two sized array
 (respectively for an _empty_, _degenerate_ or _simple_ interval), or
 an array of one or two sized arrays (for a _multiple_ interval).

```ruby
  Interval[]
  Interval[1]
  Interval[0,1]
  Interval[[0,1],[2,3],[5]]
```

Another way to initialize an Interval is by using the
 **to_interval** method on Ranges or Numbers.

```ruby
  1.to_interval
  (0..1).to_interval
  (0...2).to_interval
```

The **Infinity** constant is available for specifying intervals
 with no upper or lower boundary.

```ruby
  Interval[-Infinity, 0]
  Interval[1, Infinity]
  Interval[-Infinity, Infinity]
```

### Properties

Some natural properties of intervals:

```ruby
  Interval[1].degenerate?       # -> true
  Interval[[0,1],[2,3]].simple? # -> false
  Interval[].empty?             # -> true
  Interval[1,5].include?(3.4)   # -> true
```

### Operations

* Complement

__complement__ and __~__

```ruby
    ~Interval[0,5]             # -> Interval[[-Infinity, 0], [5, Infinity]]
```

* Union

__union__, __|__ and __+__

```ruby
Interval[0,5] | Interval[-1,3] # -> Interval[-1,5]
```

* Intersection

__intersect__, __&__, __^__

```ruby
Interval[0,5] ^ Interval[-1,3] # -> Interval[0,3]
```

* Subtraction

__minus__ and __-__

```ruby
Interval[0,5] - Interval[-1,3] # -> Interval[3,5]
```

### Classes of Intervals

You may use any comparable class

```ruby
Interval['a','c'] ^ Interval['b','d'] # -> Interval['b','c']
Interval['a','c'] | Interval['b','d'] # -> Interval['a','d']
```

Math Extensions
---------------

By requiring `borel/math_extensions` you are provided with some natural
math-related interval methods:

```ruby
Interval[1,5].rand  # -> Random.new.rand 1..5
Interval[1,5].width # -> 5-1 or 4
```

It's supported only for Numeric Comparable and arithmetic supported classes

Remarks
-------

* There is no distinction between **open** and **closed**intervals
* Complement and Minus operations have limited support for
non numeric-comparable classes

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
