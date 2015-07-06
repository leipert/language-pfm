# Known issues / Limitations

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Emphasis](#emphasis)
  - [Minor bugs](#minor-bugs)
  - [Multiline Emphasis](#multiline-emphasis)
- [Block Quotes](#block-quotes)
- [Multiline Syntax not possible](#multiline-syntax-not-possible)
<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## Emphasis

### Minor bugs

```markdown
+ ***should be bold\***
+ ****the next should *be italic***
 *italic if excactly one space is preceding*
```

### Multiline Emphasis

Multiline emphasis must start and end at the beginning of a line, so instead of:
```markdown
This is a long **multiline
markdown**
```
simply write:
```markdown
This is a long **multiline markdown**
or
This is a long
**multiline
markdown**
```

Due to limitations multiline emphasis which are not closed are still rendered:

```markdown
**multiline emphasis which
contain an empty line

**
or are not closed, are still rendered

```

## Block Quotes

```markdown
> This is a block quote
> where *most* syntax get's rendered $x+y$
> but some not:
>
> # Headers
>
> 1. lists
> > multiple block quotes

```
> This is a block quote
> where most syntax get's rendered $x+y$
> but some not:
>
> # Headers
>
> 1. lists
> > multiple block quotes

## Multiline Syntax not possible

The following do not work as they would need multiline syntax parsing:

**Setext-style Headers**
```markdown
A level-one header
==================

A level-two header
------------------
```
