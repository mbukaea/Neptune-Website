#Produces pdf version of website contents, alongside lwarp files needed
#to create the website
#Compiles website using lwarp package
function buildwebsite() {
  rm -rf public
  mkdir -p public
  
  for i in PN BD RB TS DJF DDF MGT MF OP proxyapps REF IND bib png pics corpics Animations
  do cp -r "$(pwd)/$i" ./public/
  done
  
  cp {*.tex,*.css,*.txt} public/
  cd ./public
  pdflatex  main.tex
  biber main.bcf
  pdflatex main.tex
  pdflatex main.tex
  if [ "$1" != "PDF" ]
  then
  lwarpmk html
  #Changes headers of each html file to contain name of section + adds sidebar to main page
  sed -i -e 's,<section class="textbody">,<h1>Neptune</h1>,g' main.html
  sed -i -e '/<div class="center">/r link.txt' main.html
  sed -i -e '0,/<div class="center">/{s// /}' main.html
  test=$(grep -r -n 'bodyandsidetoc' ./Engineering-Requirements-Baseline.html | cut -f1 -d:)
  test2=$(grep -r -n 'bodycontainer' ./Engineering-Requirements-Baseline.html | cut -f1 -d:)
  test3=$( expr $test2 - 3)
  sed -n "${test},${test3}p" Engineering-Requirements-Baseline.html >> sidebar.txt
  sed -i -e '/<div class="bodywithoutsidetoc">/r sidebar.txt' main.html
  for file in *.html; do file2="${file/-/ }";file3="${file2/-/ }" ; sed -i "s,<h1>main</h1>,<h1>${file3::-5}</h1>,g" ${file}; done
  test4=$(grep -r -n '<h3 id' ./main.html | cut -f1 -d:)
  test5=$(grep -r -n '</nav>' ./main.html | tail -n 1 | cut -f1 -d:)
  sed -i -e "$test4,$test5 d" main.html
  sed -i -e '693,694d' main.html
  cp main.html index.html
  #Resize images on webpages
  sed -i -e '/videoinsert/r videos.txt' Videos.html
  sed -i -e 's/videoinsert//g' Videos.html
  sed -i -e 's/Index 0/Index/g' Index-0.html
  sed -i -e 's/412/800/g' Technical-Specification.html
  sed -i -e '0,/304/{s//500/}' Technical-Specification.html
  sed -i -e 's/304/800/g' Technical-Specification.html
  sed -i -e 's/304/500/g' Technical-Specification.html
  sed -i -e '0,/304/{s//600/}' Objects-classes.html
  sed -i -e 's/304/800/g' Objects-classes.html

  fi
}

buildwebsite $1
