# FreshParse
## A light, minimal LaTeX to HTML compiler

FreshParse is a lightweight LaTeX to HTML compiler designed for LaTeX enthusiasts to be able to bring their beloved markup language to the Web. It is built using Lex and Yacc, the Unix tools for lexical analysis and parser generation.

### Phylosophy
FreshParse does not overreach, it does what it says. No CSS files nor convoluted HTML. It is meant for those who prefer to keep things simple, such as bloggers who do not like using site generators and manage their code directly.

### Syntax rules
FreshParse supports five theorem-like environments: `theorem`, `proposition`, `lemma`, `proof` and `definition`, but it is easy to add more if one desires.

It also supports the `equation` and `align` environments and lists.

All environment delimiters must be on a blank line, with nothing else on it. This makes for readable LaTeX code, so it is not restrictive in any way.

Lists support nesting but the nested environments can only contain either plain text or an environment.

Finally, the LaTeX document to be processed can contain (as it usually does) a preamble. FreshParse will just ignore it.

### Output
FreshParse wraps plain text in paragraph tags. It formats lists by inserting the `<ol>` (or `<ul>`) and `<li>` tags and it processes theorem-like environments by wrapping them up in `<div>` tags and adding `class=theorem_type`, according to the theorem-like environment in the LaTeX document. This allows you to style your theorem-like environments using CSS selectors.
