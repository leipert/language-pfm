### Math $x^2$ in headings
Inline Math should work with `$` $\frac{\frac{x+y}{2}}{y}$
and `\(` \(\frac{x+y}{y}\)

$$
\langle \vec{m} \rangle =
\frac{1}{Z(\vec{\beta})}\vec{m}(\mu)
\sum_{\mu\in\mathcal{G}}
e^{-\vec{\beta}\cdot\vec{m}(\mu)}
$$

```tex
\documentclass{scrartcl}
\usepackage{foo}
...
```

$3 \times 3$ matrix:
\[ \left\{ \begin{array}{ccc}
a & b & c \\
d & e & f \\
g & h & i \end{array} \right\}
\]

This is a:
:   Definition which spans multiple lines
    that is long

These are multiple definitions:
 ~  Definition
  ~ Definition
~   Definition ()

Inline HTML with inline markup:

<div>
### _With Math_ $x_1$
<ul>
<li>
**and lists**
</li>
</ul>
</div>
