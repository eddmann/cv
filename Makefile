all: clean html pdf

html: cv.md cv.css
	pandoc --data-dir=. --section-divs -c cv.css -f markdown -t html5 -o cv.html cv.md

pdf: html pdf.css
	wkhtmltopdf --user-style-sheet pdf.css cv.html cv.pdf

watch:
	watchmedo shell-command --patterns="*.md;*.css" --command='make' .

serve:
	python -m http.server 8080

push:
	ssh eddmann.com 'rm -rf /srv/www/eddmann/public/cv/*'
	scp cv.html eddmann.com:/srv/www/eddmann/public/cv/index.html
	scp cv.css eddmann.com:/srv/www/eddmann/public/cv/
	scp -r fonts eddmann.com:/srv/www/eddmann/public/cv/
	scp cv.pdf eddmann.com:/srv/www/eddmann/public/cv/EdwardMannProgrammerCV.pdf

clean:
	rm -f *.html *.pdf