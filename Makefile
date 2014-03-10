all: clean cv.html

cv.html: cv.md cv.css
	pandoc --data-dir=. --section-divs -c cv.css -f markdown -t html5 -o cv.html cv.md

watchdog:
	watchmedo shell-command --patterns="*.md;*.css" --command='make' .

serve:
	python -m http.server 8080

clean:
	rm -f *.html *.pdf