# Ruby metaprogramming exercises

## 1. Defining our own `attr_` methods

Remember how I told you that everything in Ruby is an object,
i.e. an instance of a class. This means that classes
themselves are also objects!

### Exercise 1.1

If every class is an object, then which class is
every class object an instance of?
Try to find out in `irb`: take a class
like `String`, and find out its class (which method do you think we need for this?).

***An instance of Class***

### Exercise 1.2

Figure out the superclass of the class you found in exercise 1.1.
***The superClass is Module***

### Exercise 1.3

The class from exercise 1.2 defines the following methods (among others):

- [`attr_reader`](https://ruby-doc.org/3.3.0/Module.html#method-i-attr_reader)
- [`attr_writer`](https://ruby-doc.org/3.3.0/Module.html#method-i-attr_writer)
- [`attr_accessor`](https://ruby-doc.org/3.3.0/Module.html#method-i-attr_accessor)

If these did not exist, we could write them ourselves. Consider the source code
in `1_my_attr_methods.rb`. It's currently using Ruby's predefined `attr_reader`,
`attr_writer`, and `attr_accessor`. However, like Frank Sinatra, we'd rather do
it our way, and write our own `my_attr_reader`, `my_attr_writer`, and
`my_attr_accessor`.

The objective of the exercise is thus to create the `my_attr_reader`, `my_attr_writer`,
and `my_attr_accessor` methods, and change the `Singer` class to use them. The test
code's output should remain the same:

```
Nancy Sinatra, born in 1940, greatest hit: "These Boots Are Made for Walkin'"
Frank Sinatra, born in 1915, greatest hit: "My Way"
```

Here are some pointers to help you get started:

- You can add methods to an existing class at any time by reopening the class,
  [this chapter from Programming Ruby](https://ruby-doc.com/docs/ProgrammingRuby/html/tut_classes.html)
  explains how that can be done. Which class should we reopen?
- Look into the [`define_method`](https://ruby-doc.org/3.3.0/Module.html#method-i-define_method),
  [`instance_variable_get`](https://ruby-doc.org/3.3.0/Object.html#method-i-instance_variable_get),
  and [`instance_variable_set`](https://ruby-doc.org/3.3.0/Object.html#method-i-instance_variable_set)
  methods.

  ***Done***

## 2. Creating a simple XML-generating DSL

In this exercise, we'll create an `XmlWriter` class, so that the following Ruby code:

```ruby
xml = XmlWriter.new.singers do
  singer do
    first_name "Frank"
    last_name "Sinatra"
  end
  singer do
    first_name "Ella"
    last_name "Fitzgerald"
  end
end

puts xml
```

Prints the following XML:

```xml
<singers>
  <singer>
    <first_name>Frank</first_name>
    <last_name>Sinatra</last_name>
  </singer>
  <singer>
    <first_name>Ella</first_name>
    <last_name>Fitzgerald</last_name>
  </singer>
</singers>
```

And so that the following Ruby code:

```ruby
xml = XmlWriter.new.books do
  book do
    title "The Hitchhiker's Guide to the Galaxy"
    author "Douglas Adams"
  end
  book do
    title "The Stranger"
    author "Albert Camus"
  end
end

puts xml
```

Prints the following XML:

```xml
<books>
  <book>
    <title>The Hitchhiker's Guide to the Galaxy</title>
    <author>Douglas Adams</author>
  </book>
  <book>
    <title>The Stranger</title>
    <author>Albert Camus</author>
  </book>
</books>
```

The output should be properly formatted with two spaces per indentation level, and
with newlines.

We don't want to write all of these different methods ourselves
(`singers`, `singer`, `first_name`, `last_name`, `books`, `book`, `title`, and `author`).
Rather, we'd like to leverage the following features of Ruby:

- Blocks
- [`method_missing`](https://ruby-doc.org/3.3.0/BasicObject.html#method-i-method_missing)
  (note: you can check if a block was given with [`block_given?`](https://ruby-doc.org/3.3.0/Kernel.html#method-i-block_given-3F))
- [`instance_eval`](https://ruby-doc.org/3.3.0/BasicObject.html#method-i-instance_eval)

To keep things simple, we'll only limit ourselves to the above 2 cases:

- An XML tag with child tags (like `singers`, `singer`, `books`, `book`), where we are using a block
- An XML tag with a string value (like `first_name`, `last_name`, `title`, and `author`)

We won't support things like attributes, self-closing tags, or XML entity escaping.

In `2_xml_dsl.rb` there's an implementation of `XmlWriter` with an empty `method_missing`.
You'll have to figure out how to write this method.

Note: you can append to a string with `<<`, e.g. `@xml << "<tag_name>value</tag_name>"`.