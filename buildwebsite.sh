#Produces pdf version of website contents, alongside lwarp files needed
#to create the website
#Compiles website using lwarp package
function buildwebsite() {
  rm -rf public
  mkdir -p public
  
  for i in PN BD RB TS DJF DDF MGT MF OP REF IND bib png corpics
  do cp -r "$(pwd)/$i" ./public/
  done
  
  cp {*.tex,*.css} public/

  pdflatex -output-directory public main.tex

  cd public
  lwarpmk html
  #Changes headers of each html file to contain name of section + adds sidebar to main page
  sed -i -e 's,<section class="textbody">,<h1>Neptune</h1>,g' main.html
  test=$(grep -r -n 'bodyandsidetoc' ./Engineering-Requirements-Baseline.html | cut -f1 -d:)
  test2=$(grep -r -n 'bodycontainer' ./Engineering-Requirements-Baseline.html | cut -f1 -d:)
  test3=$( expr $test2 - 3)
  sed -n "${test},${test3}p" Engineering-Requirements-Baseline.html >> sidebar.txt
  sed -i -e '/<div class="bodywithoutsidetoc">/r sidebar.txt' main.html
  for file in *.html; do file2="${file/-/ }";file3="${file2/-/ }" ; sed -i "s,<h1>main</h1>,<h1>${file3::-5}</h1>,g" ${file}; done
  test4=$(grep -r -n '<h3 id' ./main.html | cut -f1 -d:)
  test5=$(grep -r -n '</nav>' ./main.html | tail -n 1 | cut -f1 -d:)
  sed -i -e "$test4,$test5 d" main.html
  mv main.html index.html
}

buildwebsite

