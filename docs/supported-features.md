# Supported Features

Here is a small overview of supported features.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Emphasis (bold/italic) (██░)](#emphasis-bolditalic-%E2%96%88%E2%96%88%E2%96%91)
- [Links](#links)
- [Citations (███)](#citations-%E2%96%88%E2%96%88%E2%96%88)
- [Critic (███)](#critic-%E2%96%88%E2%96%88%E2%96%88)
- [Footnotes (███)](#footnotes-%E2%96%88%E2%96%88%E2%96%88)
- [Headers (██░)](#headers-%E2%96%88%E2%96%88%E2%96%91)
- [Links (██░)](#links-%E2%96%88%E2%96%88%E2%96%91)
- [Lists (███)](#lists-%E2%96%88%E2%96%88%E2%96%88)
- [Math (███)](#math-%E2%96%88%E2%96%88%E2%96%88)
- [Tables (░░░)](#tables-%E2%96%91%E2%96%91%E2%96%91)
- [Code Blocks & Inline Code (███)](#code-blocks-&-inline-code-%E2%96%88%E2%96%88%E2%96%88)
- [Misc](#misc)
  - [Block quotes](#block-quotes)
  - [Horizontal rules](#horizontal-rules)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Emphasis (bold/italic) (██░)

Emphasis works _like expected_ with `_` and `*`, there is **one limit**ation regarding multiline emphasis. ***Multiline*** emphasis must start and end at the beginning of a line:
```markdown
***Like this
***
**
or
this
**
*or this
*
```
More extensive examples can be found in [emphasis-block](../examples/markdown/emphasis-block.p.md) and [emphasis](../examples/markdown/emphasis.p.md).

### Links

Legend:

- ███ Fully supported feature
- ██░ Good support, some features missing
- █░░ Almost no support, a lot features missing
- ░░░ Not started (yet)
- XXX Not possible

### Citations (███)
### Critic (███)
### Footnotes (███)
### Headers (██░)

Only headers starting with `#` work. (Examples: [headers](../examples/markdown/headers.p.md))

### Links (██░)

Links to websites and E-Mails work as expected. (Examples: [links](../examples/markdown/links.p.md))
### Lists (███)

Normal lists work (Examples: [lists](../examples/markdown/lists.p.md)):

```markdown
* one
+ two
- three

1. one
1. two
2. three
```
### Math (███)
### Tables (░░░)
### Code Blocks & Inline Code (███)

### Misc
#### Block quotes

Block quotes work with inline highlighting. Nested quotes and a few other are not possible.

```markdown
> **This is a block quote**. This
  paragraph has two lines.

```

#### Horizontal rules

Use `***` and `---` for horizontal rules.
