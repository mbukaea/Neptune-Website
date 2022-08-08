rm main.aux main.log main.out main_html.aux main_html.log *.html
pdflatex main
lwarpmk html
gsed -i -e 's,<section class="textbody">,<h1>main</h1>,g' main.html
gsed -n 245,484p Engineering-Requirements-Baseline.html  >> sidebar.txt
 gsed -i -e '/<div class="bodywithoutsidetoc">/r sidebar.txt' main.html
for file in *.html; do file2="${file/-/ }";file3="${file2/-/ }" ; gsed -i "s,<h1>main</h1>,<h1>${file3::-5}</h1>,g" ${file}; done 

