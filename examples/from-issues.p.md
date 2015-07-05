## Issue #5

According to \cite{a.j,_marley_m._johnson_j.t._bigger}, Pandoc is awesome

\test{}

#### Other part

We can have some nice equations:

$$
\hat{\mu}= \frac{\sum_{i=1}^n w_i RR_i}{\sum_{i=1}^n w_i}, \,\,\,\,\,\,\,\, \frac{1}{\hat{\lambda}}= \frac{1}{n} \sum_{i=1}^n w_i \left( \frac{1}{RR_i}-\frac{1}{\hat{\mu}} \right)
$$

## Issue #4

This is a testing document for testing purposes only.[^1] This is a testing document for testing purposes only.

[^1]: This is a footnote.

## Issue #3

In Blockquote:

> "This is a quote is a quote is a quote, saying very useful things in relation to the rest of the text." [@Meyer2000]

footnote:

> "This is a quote is a quote is a quote, saying very useful things in relation to the rest of the text."^[compare to  @Fenner2012]

## Issue #2

Rmarkdown support

`r 1 + 1`

```{r knitr_options, include=FALSE}
library(knitr)
opts_chunk$set(fig.width=12, fig.height=4, fig.path='RmdFigs/',
               warning=FALSE, message=FALSE)
set.seed(53079239)
# install R/qtl package if necessary:
if(!require("qtl")) install.packages("qtl", repos="http://cran.us.r-project.org")
```

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
