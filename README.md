# Pandoc flavored Markdown package [![wercker status](https://app.wercker.com/status/e2bfecae6e8a971093516b3b3ddd4721/s/master "wercker status")](https://app.wercker.com/project/bykey/e2bfecae6e8a971093516b3b3ddd4721)
![screen shot 2015-03-14 at 15 36 12](https://cloud.githubusercontent.com/assets/2906107/6652065/f9d4048a-ca60-11e4-8c3f-c490c68b6559.png)

Adds syntax highlighting and snippets to [Pandoc flavored Markdown](http://johnmacfarlane.net/pandoc/README.html)
files in Atom. This was forked from [atoms language-gfm](https://github.com/atom/language-gfm). The goal is to maintain compatibility with the **Github Flavored Markdown** package while adding as much pandoc functionality as possible.

**Setting `language-pfm` as default**

* Disable `language-gfm`, all `.md` files will be highlighted using this package.
* Or rename pandoc flavored markdown files to `.p.md` or `.pmd`

**Supported Pandoc Features**

This package supports a lot of [pandoc features](https://github.com/leipert/language-pfm/blob/dist/docs/supported-features.md). Here are the highlights:

* Math highlighting `$...$` and `\(...\)` and block `$$...$$` and `\[...\]` (copied from [language-latex](https://atom.io/packages/language-latex))
* [Definition Lists] & [fancy lists]
* [Raw HTML] with [inline markdown]
* [Footnotes] & [Inline-Footnotes]
* [Citations]
* ... many more

There are [some quirks](https://github.com/leipert/language-pfm/blob/dist/docs/known-issues.md), but these should not affect your daily work to much.

[fancy lists]: http://johnmacfarlane.net/pandoc/README.html#extension-fancy_lists
[Citations]: http://johnmacfarlane.net/pandoc/README.html#extension-citations
[Footnotes]: http://johnmacfarlane.net/pandoc/README.html#extension-footnotes
[Inline-Footnotes]: http://johnmacfarlane.net/pandoc/README.html#extension-inline_notes
[Definition Lists]: http://johnmacfarlane.net/pandoc/README.html#extension-definition_lists
[Raw HTML]: http://johnmacfarlane.net/pandoc/README.html#extension-raw_html
[inline markdown]: http://johnmacfarlane.net/pandoc/README.html#extension-markdown_in_html_blocks

**Works great with other pandoc related packages**

* [Autocomplete Bibtex] brings citation autocompletion
* [Pen Paper Coffee] is a good looking theme for markdown editing
* [Markdown Preview Plus] is a wonderful markdown preview with Mathjax support, hopefully able to work with pandoc natively soon: [#41]

[Autocomplete Bibtex]: https://atom.io/packages/autocomplete-bibtex

[Pen Paper Coffee]: https://atom.io/packages/pen-paper-coffee-syntax

[Markdown Preview Plus]: https://atom.io/packages/markdown-preview-plus

[#27]: https://github.com/Galadirith/markdown-preview-plus/pull/41
