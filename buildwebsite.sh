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
  rm main_html.html    
  #Changes headers of each html file to contain name of section + adds sidebar to main page
  sed -i -e '/<div class="center">/r link.txt' main.html
  sed -i -e '0,/<div class="center">/{s// /}' main.html
  test=$(grep -r -n 'bodyandsidetoc' ./Engineering-Requirements-Baseline.html | cut -f1 -d:)
  test2=$(grep -r -n 'bodycontainer' ./Engineering-Requirements-Baseline.html | cut -f1 -d:)
  test3=$( expr $test2 - 3)
  test4=$( expr $test + 1)
  sed -n "${test4},${test3}p" Engineering-Requirements-Baseline.html >> sidebar.txt
  cat menustart.txt sidebar.txt menuend.txt > sidebar2.txt
  test=$(grep -r -n '<div class="sidetoctitle">' sidebar2.txt | cut -f1 -d:)
  test2=$( expr $test + 9)
  sed -i -e "$test,$test2 d" sidebar2.txt
  sed -i -e '/<div class="bodywithoutsidetoc">/r sidebar2.txt' main.html
  sed -i -e 's/<div class="bodywithoutsidetoc">/ /g' main.html
  mv ./main.html ../
  test=$(grep -r -n '<div class="bodyandsidetoc">' ./Videos.html | cut -f1 -d: )
  test2=$( expr $test + 1)
  test=$(grep -r -n '<main class="bodycontainer">' ./Videos.html | cut -f1 -d: )
  test3=$( expr $test - 1)
  sed -i -e "$test2,$test3 d" *.html
  sed -i -e '$d' sidebar2.txt
  sed -i -e '/<div class="bodyandsidetoc">/r sidebar2.txt' *.html
  mv ../main.html ./
  test=$(grep -r -n 'Download' ./main.html  | tail -n 1 | cut -f1 -d:)
  test2=$( expr $test - 1)
  sed -i -e "$test,$test2 d" main.html
  for file in *.html; do file2="${file/-/ }";file3="${file2/-/ }" ; sed -i "s,<h1>main</h1>, ,g" ${file}; done
  for file in *.html; do file2="${file/-/ }";file3="${file2/-/ }" ; file4="${file3/-/ }" ; file5="${file4/-/ }" ; file6="${file5/-/ }" ; sed -i "s,Menu,${file6::-5},g" ${file}; done
  test4=$(grep -r -n '<h3 id' ./main.html | cut -f1 -d:)
  test5=$(grep -r -n '</nav>' ./main.html | tail -n 1 | cut -f1 -d:)
  sed -i -e "$test4,$test5 d" main.html
#  sed -i -e '693,694d' main.html
  cp main.html index.html
  #Resize images on webpages
  sed -i -e '/videoinsert/r videos.txt' Videos.html
  sed -i -e 's/videoinsert//g' Videos.html
  sed -i -e 's/Index 0/Index/g' Index-0.html
  sed -i -e 's/304/500/g' Software-Engineering-Response.html
  sed -i -e 's/412/800/g' Technical-Specification.html
  sed -i -e 's/304/500/g' Technical-Specification.html
  sed -i -e '0,/304/{s//600/}' Objects-classes.html
  sed -i -e 's/304/800/g' Objects-classes.html

  fi
}

buildwebsite $1
