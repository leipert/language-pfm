# Supported Features

**This page is not completed yet**

Here is a small overview of supported features.

Legend:

- ███ Fully supported feature
- ██░ Good support, some features missing
- █░░ Almost no support, a lot features missing
- ░░░ Not started (yet)
- XXX Not possible

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Emphasis (bold/italic) (██░)](#emphasis-bolditalic-)
- [Citations (███)](#citations-)
- [Critic (███)](#critic-)
- [Footnotes (███)](#footnotes-)
- [Headers (██░)](#headers-)
- [Links (██░)](#links-)
- [Lists (███)](#lists-)
- [Math (███)](#math-)
- [Tables (░░░)](#tables-)
- [Code Blocks & Inline Code (███)](#code-blocks-&-inline-code-)
- [Misc](#misc)
  - [Block quotes](#block-quotes)
  - [Horizontal rules](#horizontal-rules)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Emphasis (bold/italic) (██░)

Emphasis works _like expected_ with `_` and `*`, there is **one limit**ation regarding multiline emphasis. ***Multiline*** emphasis must start and end at the beginning of a line:
```markdown
***bold italic
***
**
bold
**
*italic
*
```
More extensive examples can be found in [emphasis-block](../examples/markdown/emphasis-block.p.md) and [emphasis](../examples/markdown/emphasis.p.md).

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
