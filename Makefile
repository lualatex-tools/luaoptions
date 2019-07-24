manual:
	@lua -e "if tonumber(io.popen('pandoc -v'):read():gsub('pandoc (.*)', '%1'):sub(1,1)) < 2 then print('Pandoc >= 2 required') ; os.exit(1) ; end"
	pandoc -s -V fontfamily=libertine --toc-depth=4 -o luaoptions.tex luaoptions.md
	latexmk luaoptions

clean:
	git clean -fXd
