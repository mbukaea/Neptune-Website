#Removes files from previous runs
rm main.aux main.log main.out main_html.aux main_html.log *.html *lwarp*
#Produces pdf version of website contents, alongside lwarp files needed
#to create the website
pdflatex main
#Compiles website using lwarp package
lwarpmk html
#Changes headers of each html file to contain name of section + adds sidebar to main page
sed -i -e 's,<section class="textbody">,<h1>main</h1>,g' main.html
sed -n 245,484p Engineering-Requirements-Baseline.html  >> sidebar.txt
sed -i -e '/<div class="bodywithoutsidetoc">/r sidebar.txt' main.html
for file in *.html; do file2="${file/-/ }";file3="${file2/-/ }" ; sed -i "s,<h1>main</h1>,<h1>${file3::-5}</h1>,g" ${file}; done 

