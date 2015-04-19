### Emphasis

#### Bold `_`

+ __a__
+ __ab__
+ __abc__
+ __bbc___
+ __x + y + z__

NOT:

+ as __danach__fasd
+ as __danach____fasd
+ davor__asd__ as
+ in__a__word
+ in 1__8__99 numbers
+ __ abc __
+ __ abc__
+ __abc __

MULTILINE:
__sadsad
asdsadasd
__

#### Italic `_`

+ _a_
+ _ab_
+ _abc_
+ _bbc__
+ _x + y + z_

NOT:

+ as _danach_fasd
+ as _danach___fasd
+ davor_asd_ as
+ in_a_word
+ in 1_8_99 numbers
+ _ abc _
+ _ abc_
+ _abc _

#### Bold `*`

+ **a**
+ **ab**
+ **\\**
+ in**a**word
+ in 1**8**99 numbers
+ as **danach**fasd
+ davor**asd** as
+ **abc**
+ **bbc***
+ **x + y + z**

NOT:

+ **\**
+ ** **, *****, **abc*\*
+ ** abc **
+ ** abc**
+ **abc **

#### Italic `*`

+ *a*
+ *ab*
+ *\\*
+ in*a*word
+ as *danach*fasd
+ davor*asd* as
+ in 1*8*99 numbers
+ *abc*
+ *bbc**
+ *x + y + z*

NOT:

+ *\*, * *, ***, *abc*
+ * abc *
+ * abc*
+ *abc *

#### Mixed

Works:

this is ***bold italic*** text

***BoldItalic***
___BoldItalic___
**Bold *BoldItalic* Bold**
__Bold *BoldItalic* Bold__
_Italic **ItalicBold** Italic_
**Bold _BoldItalic_ Bold**
*Italic __ItalicBold__ Italic*
__Bold _BoldItalic_ Bold__

Works not:

*Italic **ItalicBold** Italic*

_Italic __ItalicBold__ Italic_



Should not work:

_\_, _ _, ____
__\__, __ __, _____

__asd \*neither is this\* asd__

**asd \_neither is this\_ asd**

__asd \**neither is this*\* asd__

__asd \_neither is this\_ asd__

#### Rest

This text is _emphasized with underscores_, and this
is *emphasized with asterisks*

This is **strong emphasis** and __with underscores__.

Working:
***bold italic***

Not Working:
*italic **bold italic** italic*
**bold *bold italic* bold**

This is * not emphasized *, and \*neither is this\*.

<span style="font-variant:small-caps;">Small caps</span>

### Horizontal rules

3 or more \*, \-, or _

*  *  *  *

---------------

___

### Smart punctuation

This is smart:

* em-dashes ---
* en-dashes --
* ellipses ...
* "Quotes"

### Block quotes

> This is a block quote. This
> paragraph has two lines.
>
> 1. This is a list inside a block quote.
> 2. Second item.

> This is a block quote. This
paragraph has two lines.

> 1. This is a list inside a block quote.
2. Second item.

> This is a block quote.
>
> > A block quote within a block quote.

### Verbatim

#### (code) blocks

Indented code blocks:

    if (a > 3) {
      moveShip(5 * gravity, DOWN);
    }

#### inline

What is the difference between `>>=` and `>>`?

Here is a literal backtick `` `as`  ``.

This is a backslash followed by an asterisk: `\*`.
