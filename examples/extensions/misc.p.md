## pandoc extensions

### extension-escaped_line_breaks

Example:

This is an example \
linebreak

----------------------------------------

### extension-line_blocks

Example:

| The limerick packs laughs anatomical
| In space that is quite economical.
|    But the good ones I've seen
|    So seldom are clean
| And the clean ones so seldom are comical

| 200 Main St.
| Berkeley, CA 94718

| The Right Honorable Most Venerable and Righteous Samuel L.
  Constable, Jr.
| 200 Main St.
| Berkeley, CA 94718

----------------------------------------

### extension-all_symbols_escapable

Example:

*\*hello\** (em)

Non\ breaking space

----------------------------------------

### extension-intraword_underscores

Example:

* feas*ible*, not feas*able*.
* feas_ible_, not feas_able_.
* feas**ible**, not feas**able**.

----------------------------------------

### extension-strikeout

Example:

This ~~is deleted text.~~ del~~et~~ed


----------------------------------------

### extension-superscript \& extension-subscript

Example:

H~2~O is a liquid.  2^10^ is 1024.

P~a\ cat~, not P~a cat~

P^a\ cat^, not P^a cat^

----------------------------------------

### extension-raw_html \& extension-markdown_in_html_blocks

Example:

<table>
  <tr>
  <td>*one*</td>
  <td>normal</td>  
  <td>[a link](http://google.com)</td>
  </tr>
</table>

----------------------------------------

### extension-raw_tex

Inline LaTeX is ignored in output formats other than Markdown, LaTeX, and ConTeXt.

Example:

This result was proved in \latex.

\begin{tabular}{|l|l|}\hline
Age & Frequency \\ \hline
18--25  & 15 \\
26--35  & 33 \\
36--45  & 22 \\ \hline
\end{tabular}

----------------------------------------

### extension-implicit_figures

Example:

With backslash:

![This is the caption](http://lorempixel.com/80/40/sports/3)

With backslash:
![This image won't be a figure](http://lorempixel.com/40/20/sports/4)\


----------------------------------------


----------------------------------------



-----

* lists_without_preceding_blankline
* hard_line_breaks
* ignore_line_breaks
* markdown_attribute
* mmd_title_block
* abbreviations
* autolink_bare_uris
* ascii_identifiers
* link_attributes
* mmd_header_identifiers
* compact_definition_lists
