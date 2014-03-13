all: clean html pdf

html: cv.md cv.css
	pandoc --data-dir=. --section-divs \
	-Minclude-before='<a href="EdwardMannDeveloperCV.pdf" id="pdf">Download PDF</a>' \
	-c cv.css -f markdown -t html5 -o index.html cv.md

pdf: html pdf.css
	wkhtmltopdf --user-style-sheet pdf.css index.html EdwardMannDeveloperCV.pdf

watch:
	watchmedo shell-command --patterns="*.md;*.css" --command='make' .

serve:
	python -m http.server 8080

push: html pdf
	ssh eddmann.com 'rm -rf /srv/www/eddmann/public/cv/*'
	scp index.html cv.css EdwardMannDeveloperCV.pdf eddmann.com:/srv/www/eddmann/public/cv/
	scp -r fonts eddmann.com:/srv/www/eddmann/public/cv/

clean:
	rm -f *.html *.pdf