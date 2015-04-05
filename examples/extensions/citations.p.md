### extension-citations

#### Known bugs / limitations

* Citations [@fenner12a [p. 12] can have brackets inside]. We cannot find matching brackets, so a workaround would be escaping them: [@fenner12a \[p. 12\] - ]

#### Citations

* solo: @fenner12a
* with page after: @fenner12b [p. 33]
* without name: Fenner says in [-@fenner12b]...
* Multiple: [@fenner12b; @fenner12a]
* with inline Format: [see @fenner12a, \[pp. 33-35\]; also @fenner12b, pp. 33 and *passim* ~~123~~ $x^2$ ].
* inside Footnote^[compare to [@fenner12b]]
* @fenner12b; @fenner12a [ p. 33 ]
* @fenner12b[]

GFM Mentions: @fenner12a '@fenner12a' @fenner12a's @fenner12a. @fenner12a, (@fenner12a) [@fenner12a]

###### In Headline: [@fenner12a]

In Blockquote:

> "This is a quote is a quote is a quote, saying very useful things in relation to the rest of the text." [@fenner12a]

footnote:

> "This is a quote is a quote is a quote, saying very useful things in relation to the rest of the text."^[compare to [ @fenner12b]]

#### No Citations

sentence with no space before@fenner12a

@fenner12b foo [p. 33] should not get grouped.

No citation: [S.175]

Inside math: $@fenner12a$

----

#### References

---
references:
- id: fenner12a
  title: One-click science marketing
  author:
  - family: Fenner
    given: Martin
  container-title: Nature Materials
  volume: 11
  URL: 'http://dx.doi.org/10.1038/nmat3283'
  DOI: 10.1038/nmat3283
  issue: 4
  publisher: Nature Publishing Group
  page: 261-263
  type: article-journal
  issued:
    year: 2012
    month: 3
- id: fenner12b
  title: One-click science marketing
  author:
  - family: Fenner
    given: Martin
  container-title: Nature Materials
  volume: 11
  URL: 'http://dx.doi.org/10.1038/nmat3283'
  DOI: 10.1038/nmat3283
  issue: 4
  publisher: Nature Publishing Group
  page: 261-263
  type: article-journal
  issued:
    year: 2012
    month: 3
...
