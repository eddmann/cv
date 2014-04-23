all: clean html pdf txt

html: cv.md cv.css
	pandoc --data-dir=. --section-divs \
	-Minclude-before='<a href="EdwardMannDeveloperCV.pdf" id="pdf">Download PDF</a>' \
	-c cv.css -f markdown -t html5 -o index.html cv.md

pdf: html pdf.css
	# wkhtmltopdf --user-style-sheet pdf.css index.html EdwardMannDeveloperCV.pdf
	vagrant ssh -c "xvfb-run --server-args=\"-screen 0, 1024x680x24\" wkhtmltopdf --user-style-sheet /vagrant/pdf.css /vagrant/index.html /vagrant/EdwardMannDeveloperCV.pdf"

txt: cv.md
	pandoc -f markdown -o EdwardMannDeveloperCV.txt cv.md

watch:
	watchmedo shell-command --patterns="*.md;*.css" --command='make' .

serve:
	python -m http.server 8080

push: html pdf txt
	ssh eddmann.com 'rm -rf /srv/www/eddmann/public/cv/*'
	scp index.html cv.css EdwardMannDeveloperCV.txt EdwardMannDeveloperCV.pdf eddmann.com:/srv/www/eddmann/public/cv/
	scp -r fonts eddmann.com:/srv/www/eddmann/public/cv/

clean:
	rm -f *.html *.pdf EdwardMannDeveloperCV.txt