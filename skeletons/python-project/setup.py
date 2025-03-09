from setuptools import setup, find_packages

setup(
    name="DUMMY_NAME",
    version="DUMMY_VERSION",
    packages=find_packages(),
    install_requires=["click"],
    entry_points={
        "console_scripts": [
            "DUMMY_NAME=DUMMY_NAME.main:main",
        ],
    },
)
