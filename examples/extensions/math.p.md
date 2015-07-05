### extension-latex_macros

<!-- TODO: Example -->

Example:

----------------------------------------

### extension-tex_math_dollars & extension-tex_math_single_backslash & extension-tex_math_double_backslash

<!-- TODO:

Anything between two $ characters will be treated as TeX math. The opening $ must have a non-space character immediately to its right, while the closing $ must have a non-space character immediately to its left, and must not be followed immediately by a digit.

-->

Example:

No math $20,000 and $30,000, \$50000\$

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
