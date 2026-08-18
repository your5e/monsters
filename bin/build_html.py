#!/usr/bin/env python

import argparse
import re
import shutil
from pathlib import Path

import markdown
import tomllib
from jinja2 import Environment, FileSystemLoader
from markupsafe import Markup

# Obsidian image embed: ![[path|alt]] or ![[path]]
EMBED = re.compile(r"!\[\[([^|\]]+)(?:\|([^\]]*))?\]\]")

# Obsidian wikilink: [[target]] or [[target|label]]
WIKILINK = re.compile(r"\[\[([^\]]+)\]\]")


def resolve_embeds(text, source_dir, images_out):
    def replace(match):
        target, alt = match.group(1), match.group(2) or ""
        image = source_dir.joinpath(target)
        images_out.mkdir(parents=True, exist_ok=True)
        shutil.copy(image, images_out.joinpath(image.name))

        return f"![{alt}](/images/{image.name})"

    return EMBED.sub(replace, text)


def strip_wikilinks(text):
    def label(match):
        return match.group(1).split("|")[-1]

    return WIKILINK.sub(label, text)


def convert(source, images_out):
    text = resolve_embeds(source.read_text(), source.parent, images_out)
    text = strip_wikilinks(text)
    html = markdown.markdown(text, extensions=["extra"])

    return Markup(html)


def build(manifest, out):
    base_dir = manifest.parent
    files = tomllib.loads(manifest.read_text())["files"]

    loader = FileSystemLoader("templates")
    env = Environment(loader=loader, autoescape=True)
    monster = env.get_template("monster.html")
    base = env.get_template("base.html")

    entries = []
    for entry in files:
        content = convert(base_dir.joinpath(entry), out.joinpath("images"))
        entries.append(monster.render(content=content))

    body = Markup("\n".join(entries))
    document = base.render(body=body)

    out.mkdir(parents=True, exist_ok=True)
    out.joinpath("monsters.html").write_text(document)

    shutil.copytree(
        "assets",
        out.joinpath("assets"),
        dirs_exist_ok=True,
    )


def main():
    parser = argparse.ArgumentParser(description="Build the monster HTML site.")
    parser.add_argument(
        "manifest",
        type=Path,
        help="TOML manifest of sources",
    )
    parser.add_argument(
        "output",
        type=Path,
        help="directory to build into",
    )

    args = parser.parse_args()
    build(args.manifest, args.output)


if __name__ == "__main__":
    main()
