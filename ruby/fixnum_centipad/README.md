### Fixnum Centipad

```
Given a range of Fixnum (1..9)
Using only the operators + -
and combining near terms into a single Fixnum, eg. 12 345 67
How many ways can you create the Fixnum 100?
  * A Fixnum cannot be used twice.
  * The order must be maintained 1 to 9.

Also see https://www.youtube.com/watch?v=sglZGSwK6ow
```

Usage Examples

```ruby
>> Centipad.new(1,9,100,true).solve
=> 123+45-67+8-9
   123+4-5+67-89
   123-45-67+89
   123-4-5-6-7+8-9
   12+3+4+5-6-7+89
   12+3-4+5+67+8+9
   12-3-4+5-6+7+89
   1+23-4+56+7+8+9
   1+23-4+5+6+78-9
   1+2+34-5+67-8+9
   1+2+3-4+5+6+78+9
   11
   Time elapsed 65.826 milliseconds
```

```ruby
>> Centipad.new(1,9,100,false).solve
=> 11
   Time elapsed 61.615 milliseconds
```

```ruby
>> Centipad.new().solve
=> 11
   Time elapsed 61.615 milliseconds
```
