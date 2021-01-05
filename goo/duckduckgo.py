import pandas
import requests
from typer import Typer
from time import sleep
from bs4 import BeautifulSoup
from random import randint

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36"
}
app = Typer()


def duckduckgo(query: str):
    url = f"https://html.duckduckgo.com/html/"
    r = requests.post(url, headers=HEADERS, data={"q": query})
    if not r.ok:
        return pandas.DataFrame([])
    soup = BeautifulSoup(r.content, "lxml")
    return pandas.DataFrame(
        [
            (query, x.get("href"), x.text)
            for x in soup.find_all("a", class_="result__snippet")
        ]
    )


@app.command()
def go(file: str, outfile: str):
    df = pandas.read_csv(file)
    pages = []
    for _, (q,) in df.iterrows():
        page = duckduckgo(q)
        pages.append(page)
        sleep(5 + randint(4, 9))
    return pandas.concat(pages).to_csv(outfile)


if __name__ == "__main__":
    app()