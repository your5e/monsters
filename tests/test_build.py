import subprocess
import sys


def test_build_copies_the_right_things(tmp_path):
    out = tmp_path.joinpath("build")
    subprocess.run(
        [sys.executable, "bin/build_html.py", "tests/index.toml", out],
        check=True,
    )

    html = out.joinpath("monsters.html").read_text()

    assert "Aboleth" in html  # name
    assert "<strong>AC</strong> 17" in html  # armour class
    assert "Amphibious" in html  # a feature
    assert "[[" not in html  # wikilinks stripped
    assert "/images/Aboleth.png" in html  # image referenced
    assert out.joinpath("images", "Aboleth.png").is_file()  # image copied
    assert out.joinpath("assets", "Lora.ttf").is_file()  # font copied
