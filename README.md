# London Baptist Confession of Faith (1689)

This repository contains several representations of the [Baptist
Confession of Faith of 1689](https://en.wikipedia.org/wiki/1689_Baptist_Confession_of_Faith),
a document written in 1677 and published in 1689 by Calvinistic Baptists in London.
The LBCF is currently used by many Reformed Baptist churches as a statement of
faith.

Here are the different formats available:
* [Web page](http://lbcf.walen.me) with scripture references
* [Markdown](https://github.com/lwalen/lbcf-1689/blob/master/lbcf.md)
* [LaTeX](https://github.com/lwalen/lbcf-1689/blob/master/latex/lbcf.tex)
* [PDF, compiled from the LaTeX source](https://github.com/lwalen/lbcf-1689/blob/master/latex/lbcf.pdf)
* [Alternative webpage (HTML), also compiled from LaTeX using HTLatex](https://github.com/lwalen/lbcf-1689/blob/master/latex/lbcf.html) (requires accompanying CSS file)
* [JSON](https://github.com/lwalen/lbcf-1689/blob/master/lbcf.json)

## Creating the PDF and HTML from LaTeX Source
Collated and typesetted by [Nathaniel Schmidt](https://github.com/njsch)

Although this may seem complicated at face-value, this can be made quite easy with a text editor such as [TeXWorks](http://www.tug.org/texworks/) or [TeXLive](https://tug.org/texlive/).  TeXWorks is probably the easier to install and comes automatically installed with packages such as [MiKTeX](https://miktex.org/) on Windows.  You can probably compile from Microsoft's [Visual Studio Code](https://code.visualstudio.com/) as well, provided you install any of the relevant extensions.

These packages and editors usually require external packages to be installed before you compile a document.  The LBCF LaTeX document requires the Hyperref and the Tabularx packages as base requirements for it, so you may have to accept a prompt to install it, unless you have set external packages to install automatically.

Installing can probably be done via a graphical desktop interface; however, it should be as simple as the following via command line :
`cd` (change directories / folders) to the folder where the document is located and just type
```
pdflatex lbcf.tex
```
to create the PDF from a text-based console or terminal, such as the terminal in Mac OS or Linux, or otherwise you can use the Windows Command Prompt or Powershell. Alternatively, with MiKTeX you can use Texify instead of Pdflatex if you wish.

To create the html, just call
```
htlatex lbcf.tex
```
.

Please preserve the file extension if you make any changes.

## Issues and feature requests
Please use the [issue tracker in GitHub](https://github.com/lwalen/lbcf-1689/issues)
or email <mailto:lars@walen.me> to report any issues you find, and to suggest
new features.

## Contributing
Contributions are welcome! Feel free to fork this repository and make a pull
request with your changes.
