manual:
	@lua -e "if tonumber(io.popen('pandoc -v'):read():gsub('pandoc (.*)', '%1'):sub(1,1)) < 2 then print('Pandoc >= 2 required') ; os.exit(1) ; end"
	pandoc -s -V fontfamily=libertine --toc-depth=4 -o luaoptions.tex luaoptions.md
	latexmk luaoptions

clean:
	git clean -fXd

ctan: manual
	mkdir -p ./ctan/luaoptions
	cp -R luaoptions.sty luaoptions*.lua \
		latexmkrc luaoptions*.cls \
		luaoptions.tex luaoptions.pdf LICENSE Contributors.md \
		./ctan/luaoptions/
	echo 'Main author: [Fr. Jacques Peron](mailto:cataclop@hotmail.com)\nThis material is subject to the MIT license.\n' \
		> ./ctan/luaoptions/README.md
	cat README.md >> ./ctan/luaoptions/README.md
	(cd ctan/ ; zip -r luaoptions luaoptions)
