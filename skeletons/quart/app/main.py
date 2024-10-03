from quart import Quart, render_template
from quart_cors import cors

DEFAULT_PORT = 4444
DEFAULT_HOST = "0.0.0.0"
DEFAULT_DEBUG = True
DEFAULT_CERTFILE = "/opt/quart/skeleton/app/keys/cert.pem"
DEFAULT_KEYFILE = "/opt/quart/skeleton/app/keys/key.pem"
DEFAULT_NAME = "app"

APP = Quart(__name__)
APP = cors(
    APP,
    allow_origin=["*"],
    allow_headers=["*"],
    allow_methods=["*"],
    allow_credentials=False,
)


@APP.get("/")
async def main():
    """Default Endpoint"""
    tpl = await render_template("layout.html", title=DEFAULT_NAME)
    return tpl


if __name__ == "__main__":
    APP.run(
        debug=DEFAULT_DEBUG,
        host=DEFAULT_HOST,
        port=DEFAULT_PORT,
        certfile=DEFAULT_CERTFILE,
        keyfile=DEFAULT_KEYFILE,
    )
