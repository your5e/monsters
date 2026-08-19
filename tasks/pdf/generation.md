Produce a downloadable PDF of the collection, built from the Markdown sources.
Rendering to templated HTML with CSS, using WeasyPrint to then turn that into
a PDF whenever a commit is release tagged on main.

@queue

- [X] script to output templated HTML from Markdown
- [X] docker image for WeasyPrint
- [ ] generate PDF on push
