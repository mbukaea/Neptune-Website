# Neptune-Website
To compile the website you will need the lwarp package installed
through your tex package manager, poppler utilities and Perl to
be installed on your system. To compile the website use run.sh .
Tex package manager used in tests was Miktex.


## Installation on ubuntu

It should be sufficient to first clone this repo, cd into the directory and then:

```
sudo apt install -y texlive-latex-extra
sudo apt install -y texlive-lang-japanese
sudo apt-get install -y texlive-bibtex-extra biber
mkdir public
bash buildwebsite.sh
```
