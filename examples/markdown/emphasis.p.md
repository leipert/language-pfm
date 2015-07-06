### Emphasis

#### Known bugs / limitations

+ ***should be bold\***
+ ****the next is *italic***

#### BoldItalic `_`

+ ___a___
+ ___ab___
+ ___abc___
+ ___abc___,
+ :___abc___
+ ___bbc____
+ ___x + y + z___
+ ___abc ___
+ ___\\___

Should not work:

+ ____bbc___
+ ___ abc ___
+ ___ abc___
+ ___\___
+ ___ ___
+ __________
+ ___

#### BoldItalic `*`

+ ***a***
+ ***ab***
+ ***abc***
+ ***abc***,
+ :***abc***
+ ***bbc****
+ ***bbc****
+ ***x + y + z***
+ ***abc ***
+ ***\\***

Should not work:

+ ****bbc***
+ *** abc ***
+ *** abc***
+ ***\***
+ *** ***
+ **********
+ ***  

#### Bold `_`

+ __a__
+ __ab__
+ __abc__
+ __abc__,
+ :__abc__
+ __bbc___
+ __x + y + z__
+ __abc __
+ as __danach____fasd
+ ___asd__
+ __\\__

Should not work:

+ davor__asd__ as
+ in__a__word
+ in 1__8__99 numbers
+ __ abc __
+ __ abc__
+ __abc\__
+ __\__
+ __ __
+ __________
+ ___

#### Italic `_`

+ _a_
+ _ab_
+ _abc_
+ _abc_,
+ :_abc_
+ _x + y + z_
+ _abc _
+ ___asd_
+ _bbc___

NOT:

+ __asd_
+ _\_
+ _ _
+ ____
+ as _danach_fasd
+ as _danach___fasd
+ davor_asd_ as
+ in_a_word
+ in 1_8_99 numbers
+ _ abc _
+ _ abc_
+ _bbc__


#### Bold `*`

+ **a**
+ **ab**
+ :**abc**
+ **\\**
+ **abc**,
+ in**a**word
+ in 1**8**99 numbers
+ as **danach**fasd
+ davor**asd** as
+ **abc**
+ **bbc***
+ ***asd**
+ **x + y + z**
+ **abc **

NOT:

+ **\**
+ ***
+ *****
+ **abc*\*
+ ** abc **
+ ** abc**


#### Italic `*`

+ *a*
+ *ab*
+ *\\*
+ *abc*,
+ :*abc*
+ in*a*word
+ as *danach*fasd
+ davor*asd* as
+ in 1*8*99 numbers
+ *abc*
+ *x + y + z*
+ *abc*
+ ***asd*
+ *abc***
+ *abc****
+ *abc*****

NOT:

+ *\*
+ * *
+ ***
+ * abc *
+ **asd*
+ * abc*
+ *abc**

#### Non-EMPHASIS `[_*]{4,}`

+ *****$x+y$*****
+ ____TE*ST*____
+ ____****$x+y$****____
+ ****TEST****`

#### Mixed

Works:

this is ***bold italic*** text

+ ***BoldItalic***
+ ___BoldItalic___
+ **Bold *BoldItalic* Bold**
+ __Bold *BoldItalic* Bold__
+ _Italic **ItalicBold** Italic_
+ **Bold _BoldItalic_ Bold**
+ *Italic __ItalicBold__ Italic*
+ __Bold _BoldItalic_ Bold__
+ *Italic **ItalicBold** Italic*
+ _Italic __ItalicBold__ Italic_

Middle should not be highlighted:

+ __asd \*neither is this\* asd__

+ **asd \_neither is this\_ asd**

+ __asd \*neither is this* asd__

+ __asd \_neither is this_ asd__

#### Start of lines

*$x+y$*
 *$x+y$*
  *$x+y$*
**$x+y$**
 **$x+y$**
  **$x+y$**
***$x+y$***
 ***$x+y$***
  ***$x+y$***
