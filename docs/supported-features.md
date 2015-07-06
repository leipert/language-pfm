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
  - [Strike-Out (`~~`) (█░░)](#strike-out--)
  - [Superscript (`^`) and Subscript (`~`) (░░░)](#superscript--and-subscript--)
- [Citations (███)](#citations-)
- [Critic (███)](#critic-)
- [Footnotes (███)](#footnotes-)
- [Headers (██░)](#headers-)
- [Links (██░)](#links-)
- [Lists (███)](#lists-)
  - [Fancy Lists](#fancy-lists)
  - [Definition Lists](#definition-lists)
- [Math (███)](#math-)
- [Tables (██X)](#tables-)
- [Code Blocks & Inline Code (███)](#code-blocks-&-inline-code-)
- [Metadata (█░░)](#metadata-)
- [Block quotes (██░)](#block-quotes-)
- [Horizontal rules (██░)](#horizontal-rules-)
- [Inline HTML & Tex (██░)](#inline-html-&-tex-)
- [Miscellaneous](#miscellaneous)
  - [Escaped Line-Breaks (░░░)](#escaped-line-breaks-)
  - [Line-Blocks (░░░)](#line-blocks-)

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

#### Strike-Out (`~~`) (█░░)

<!--TODO-->Not supported inside a word at the moment

```markdown
This ~~is deleted text.~~ not~~supported~~yet
```

#### Superscript (`^`) and Subscript (`~`) (░░░)

<!--TODO-->Not supported at the moment

```markdown
+ H~2~O is a liquid.  2^10^ is 1024.
+ P~a\ cat~, not P~a cat~
+ P^a\ cat^, not P^a cat^
```

### Citations (███)

Fully compatible:

```markdown
* solo: @Meyer2000
* with page after: @Fenner2012 [p. 33]
* without name: Fenner says in [-@Fenner2012]...
* Multiple: [@Fenner2012; @Meyer2000]
* with inline Format: [see @Meyer2000, \[pp. 33-35\]; also @Fenner2012, pp. 33 and *passim* ~~123~~ $x^2$ .]
* inside Footnote^[compare to [@Fenner2012]]
```

### Critic (███)

Fully compatible (support copied from language-gfm)

```markdown
This is critic {++ Please add ++}, {-- Delete --}, {== Highlight ==}, {>> Comment <<}, {~~ Substitue~>This ~~}
```

### Footnotes (███)

Fully compatible.

```markdown
Inline Note 2^[@author **x** S.175 $x$]
Foot[^1] note[^Foot:.#$%&-+?<>~/äNote]

[^Foot:.#$%&-+?<>~/äNote]: Footnote

[^1]: Here is the footnote.

```

### Headers (██░)

Only headers starting with `#` work. (Examples: [headers](../examples/markdown/headers.p.md))

<!-- TODO --> Header attributes are currently not supported.

### Links (██░)

Links to websites and E-Mails work as expected. (Examples: [links](../examples/markdown/links.p.md))

```markdown
* http://google.com
* This is an [inline link](/url), and here's [one with
a title](http://fsf.org "click here for a good time!").
* Here is [my link][FOO]
* ![la lune](http://lorempixel.com/400/200/sports/1 "Voyage to the moon")

[Foo]: /bar/baz

```

<!--TODO: --> Currently not working:

```markdown
* [my website]
* ![movie reel]

[movie reel]: http://lorempixel.com/400/200/sports/2
```

### Lists (███)

Normal ordered and unordered lists are fully supported.

```markdown
* one
+ two
- three

1. one
2. three
```

#### Fancy Lists

Fancy lists are fully supported.

```markdown
#. one
A) one
(i) one
a. one
B.  one
```

#### Definition Lists

Definition lists are fully supported.

```markdown
Term 1

:   Definition 1 with *inline markup*

Term 1
 ~  Definition 1
```

### Math (███)

```markdown
Inline Math should work with `$` $\frac{\frac{x+y}{2}}{y}$
and `\(` \(\frac{x+y}{y}\)

$$
\langle \vec{m} \rangle =
\frac{1}{Z(\vec{\beta})}\vec{m}(\mu)
\sum_{\mu\in\mathcal{G}}
e^{-\vec{\beta}\cdot\vec{m}(\mu)}
$$

$3 \times 3$ matrix:
\[ \left\{ \begin{array}{ccc}
a & \left(b\right) & c \\
d & e & f \\
g & h & i \end{array} \right\}
\]
```

### Tables (██X)

Pandoc Tables are mostly not supported and it looks rather bad to support all of pandocs tables.

- Not possible: extension-table_captions \& extension-simple_tables
- Not possible: extension-multiline_tables
- Possible: extension-grid_tables
- Supported: extension-pipe_tables, support comes from language-gfm


### Code Blocks & Inline Code (███)

Supports fenced code-blocks with **~~~** or **\`\`\`**. Inline code is wrapped in **\`**.

Also fully supports the extensions:

- extension-fenced_code_attributes
- extension-inline_code_attributes
- extension-fenced_code_blocks

<!--TODO : --> Example picture:

### Metadata (█░░)

### Block quotes (██░)

Block quotes work with inline highlighting. Nested quotes and a few other are not possible.
a
```markdown
> **This is a block quote**. This
  paragraph has two lines.

```

### Horizontal rules (██░)

Use `***` and `---` for horizontal rules.

### Inline HTML & Tex (██░)

### Miscellaneous

#### Escaped Line-Breaks (░░░)

#### Line-Blocks (░░░)
