Borel
=====

Borelian sets are sets formed by enumerable union, intersection or complement, of intervals.

**Borel** enables performing regular operations on any ordered set.

**Borel** was mainly inspired on the **Intervals** [gem][1].

[1]: http://intervals.rubyforge.org

Usage
-----

### Initializing

An Interval can be initialized with an empty, one or two sized array (respectively for an _empty_, _degenerate_ or _simple_ interval), or an array of one or two sized arrays (for a _multiple_ interval).

```ruby
Interval[]
Interval[1]
Interval[0,1]
Interval[[0,1],[2,3],[5]]
```

Another way to initialize an Interval is by using the **to_interval** method on Ranges or Numbers.

```ruby
1.to_interval
(0..1).to_interval
(0...2).to_interval
```

The **Infinity** constant is available for specifying intervals with no upper or lower boundary.

```ruby
Interval[-Infinity, 0]
Interval[1, Infinity]
Interval[-Infinity, Infinity]
```

### Properties

Some natural properties of intervals:

```ruby
Interval[1].degenerate?       # true
Interval[[0,1],[2,3]].simple? # false
Interval[].empty?             # true
Interval[1,5].include?(3.4)   # true
```

### Operations

* Complement

__complement__ and __~__

```ruby
~Interval[0,5] == Interval[[-Infinity, 0], [5, Infinity]]
```

* Union

__union__, __|__ and __+__

```ruby
Interval[0,5] | Interval[-1,3] == Interval[-1,5]
```

* Intersection

__intersect__, __&__, __^__

```ruby
Interval[0,5] ^ Interval[-1,3] == Interval[0,3]
```

* Subtraction

__minus__ and __-__

```ruby
Interval[0,5] - Interval[-1,3] == Interval[3,5]
```

### Remarks

* At the moment there is no distinction between **open** and **closed** intervals.

* There is limited support for non-numeric classes intervals
