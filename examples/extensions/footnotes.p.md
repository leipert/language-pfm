### extension-footnotes & extension-inline_notes

Issues:

bla bla^[@ab]

bla [...] bla^[@ab]

bla [...] bla^[@a]

> bla bla^[@ab]

> bla [...] bla^[@ab]

> bla [...] bla^[@a]

Example:

Inline Note^[S.175]

Inline Note 2^[@author **x** S.175 $x$]

Inline Note 3^[^Muhahaha]

Inline Note 4 ^[ ^Muhahaha]

No Inline Note 3 ^[^ Muhahaha]

Here is a footnote reference,[^1] and another.[^longnote]

Footnote[^Foot:.#$%&-+?<>~/äNote]

[^Foot:.#$%&-+?<>~/äNote]: Footnote

[^1]: Here is the footnote.

[^longnote]: Here's one with multiple blocks.

    Subsequent paragraphs are indented to show that they
    belong to the previous footnote.

    ```
    { some.code }
    ```


    The whole paragraph can be indented, or just the first
    line.  In this way, multi-paragraph footnotes work like
    multi-paragraph list items.

Not in the footnote anymore
