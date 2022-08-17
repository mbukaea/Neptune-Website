# Neptune-Website
To compile the website you will need the lwarp package installed
through your tex package manager, poppler utilities and Perl to
be installed on your system. To compile the website use run.sh .
Tex package manager used in tests was Miktex.


## Installation on Ubuntu 22.04

It should be sufficient to first clone this repo, cd into the directory and then:

```
sudo apt install -y biber latexmk texlive-bibtex-extra texlive-lang-japanese texlive-latex-extra texlive-latex-recommended 
mkdir public
bash buildwebsite.sh
```

then open `public/index.html` in your preferred browswer.

## Installation in WSL
If you've installed the Ubuntu 22.04 distro, you can follow the corresponding instructions above.
Note that Ubuntu 22.04 is now available on the MS Store, no need to manually upgrade an earlier version.

To view the website from a browser in windows, go to 
```
file://wsl%24/Ubuntu-22.04[path_to_website_repo]/public/index.html
````