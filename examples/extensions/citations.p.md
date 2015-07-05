### extension-citations

#### Known bugs / limitations

* Citations [@Meyer2000 [p. 12] can have brackets inside]. We cannot find matching brackets, so a workaround would be escaping them: [@Meyer2000 \[p. 12\] - ]

#### Citations

* solo: @Meyer2000
* with page after: @Fenner2012 [p. 33]
* without name: Fenner says in [-@Fenner2012]...
* Multiple: [@Fenner2012; @Meyer2000]
* with inline Format: [see @Meyer2000, \[pp. 33-35\]; also @Fenner2012, pp. 33 and *passim* ~~123~~ $x^2$ .]
* inside Footnote^[compare to [@Fenner2012]]
* @Fenner2012; @Meyer2000 [ p. 33 ]
* @Fenner2012[]

GFM Mentions: @Meyer2000 '@Meyer2000' @Meyer2000's @Meyer2000. @Meyer2000, (@Meyer2000) [@Meyer2000]

###### In Headline: [@Meyer2000]

In Blockquote:

> "This is a quote is a quote is a quote, saying very useful things in relation to the rest of the text." [@Meyer2000]

footnote:

> "This is a quote is a quote is a quote, saying very useful things in relation to the rest of the text."^[compare to [ @Fenner2012]]

#### No Citations

sentence with no space before@Meyer2000

@Fenner2012 foo [p. 33] should not get grouped.

No citation: [S.175]

Inside math: $@Meyer2000$

----

#### References

---
references:
- id: Meyer2000
  title: A constraint-based framework for diagrammatic reasoning
  author:
  - family: Meyer
    given: Bernd
  container-title: Applied Artificial Intelligence
  volume: 14
  issue: 4
  publisher: Nature Publishing Group
  page: 327-344
  type: article-journal
  issued:
    year: 2000
- id: Fenner2012
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
