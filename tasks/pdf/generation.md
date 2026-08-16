Produce a downloadable PDF of the collection, built from the Markdown sources.
Rendering to templated HTML with CSS, using WeasyPrint to then turn that into
a PDF whenever a commit is release tagged on main.

@queue

- [ ] script to output templated HTML from Markdown
- [ ] docker image for WeasyPrint
        - workflow to build and push to registry
- [ ] generate PDF on push
