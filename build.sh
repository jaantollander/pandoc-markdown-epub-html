#!/bin/bash
CONTENTDIR="content"
BUILDDIR="build"
FILENAME="index"
ASSETSDIR="assets"

download_csl() {
    mkdir "${ASSETSDIR}" -p
    wget -O "${ASSETSDIR}/citation-style.csl" \
        "https://raw.githubusercontent.com/citation-style-language/styles/master/harvard-anglia-ruskin-university.csl"
}

epub() {
    mkdir "${BUILDDIR}" -p
    echo "Creating EPUB output"
    pandoc "${CONTENTDIR}/${FILENAME}".md \
        --resource-path="${CONTENTDIR}" \
        --citeproc \
        --csl="${ASSETSDIR}/citation-style.csl" \
        --from="markdown+tex_math_single_backslash+tex_math_dollars" \
        --to="epub" \
        --output="${BUILDDIR}/output.epub" \
        --epub-cover-image="${ASSETSDIR}/cover.png" \
        --mathml \
        --toc
}

html() {
    mkdir "${BUILDDIR}/html" -p
    echo "Creating HTML output"
    rm -fr "${BUILDDIR}/html/media"
    pandoc "${CONTENTDIR}/${FILENAME}.md" \
        --resource-path="${CONTENTDIR}" \
        --extract-media="media/html" \
        --citeproc \
        --csl="${ASSETSDIR}/citation-style.csl" \
        --from="markdown+tex_math_single_backslash+tex_math_dollars" \
        --to="html5" \
        --output="${BUILDDIR}/html/output.html" \
        --mathjax \
        --standalone
    mv "media" "build/html"
}

clean() {
    rm -r "${BUILDDIR}"
}

# Allows to call a function based on arguments passed to the script
# Example: `./build.sh pdf_print`
$*
