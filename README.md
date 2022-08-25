# Neptune-Website

## Installation on Ubuntu 22.04

It should be sufficient to first clone this repo, cd into the directory and then:

```
sudo apt install -y biber latexmk texlive-bibtex-extra texlive-lang-japanese texlive-latex-extra texlive-latex-recommended 
mkdir public
bash buildwebsite.sh
```

then open `public/index.html` in your preferred browser.

## Installation in WSL
### Ubuntu 22.04
To build the website, follow the instructions for the native linux distro above.
N.B: Ubuntu 22.04 is now available on the MS Store, no need to manually upgrade an earlier version.

To view the website from a browser in windows, go to 
```
file://wsl%24/Ubuntu-22.04[path_to_website_repo]/public/index.html
```

### Ubuntu 20.04
Note that the instructions for 22.04 won't work for 20.04, as the `texlive-latex-recommended` package contains an older version of lwarp.
While it may be possible to upgrade lwarp, there are issues with using `tlmgr` that make this non-trivial.
