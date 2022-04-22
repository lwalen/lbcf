# London Baptist Confession of Faith (1689)
## LaTeX Source and Output
Collated and typesetted by [Nathaniel Schmidt](https://github.com/njsch)

## Introduction
This repository sub-directory contains several representations of the [Baptist Confession of Faith of 1689](https://en.wikipedia.org/wiki/1689_Baptist_Confession_of_Faith), a document written in 1677 and published in 1689 by Calvinistic Baptists in London. In this instance, it has been typesetted in plain text [LaTeX](https://www.latex-project.org/) source, which has a number of benefits as outlined below.
The LBCF is currently used by many Reformed Baptist churches as a statement of
faith.

## Features
### Different Readable output formats
Here are the different formats available:
* [LaTeX source](https://github.com/lwalen/lbcf-1689/blob/master/latex/lbcf.tex)
* [PDF, compiled from the LaTeX source](https://github.com/lwalen/lbcf-1689/blob/master/latex/lbcf.pdf)
* [Webpage (HTML), also compiled from LaTeX using HTLatex](https://github.com/lwalen/lbcf-1689/blob/master/latex/lbcf.html) (requires accompanying CSS file)

They are created for you or you can build them yourself with the relevant tools.

### Preset booklet-style front matter, main matter and back matter
The book automatically structures itself appropriately according to LaTeX preparation standards. It creates a table of contents for you upon compilation without you having to create it.

### Easy-to-use labels for everything, including chapters and paragraphs
The many labels make it very easy for you to create in-page links to any portion, or sub-portion, of the material without fuss. You can specify specific paragraphs without having to generally point someone to a chapter and expect them to find the right sub-section.

### Built with Accessibility in Mind
If you uncomment the right lines, this document can be quite useful for the blind of vision/visually impaired reader/user. The Axessibility package allows for propper tagging to take place in PDF documents. the spacing command can be changed to produce the document using one-and-a-half spacing instead of just single spacing, or even double spacing if you want it. A consistent font is used that is usually favourable to most partially sighted users.

## Creating the PDF and HTML from LaTeX Source
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
Feel free to contact the main developer, Lars Walen, in the readme for the root directory, or contact Nathaniel Schmidt (see beginning of sub-dir readme file).