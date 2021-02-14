import setuptools

setuptools.setup(
    name="pico-wizard",
    version="0.1.0",
    author="Anupam Basak",
    author_email="anupam.basak27@gmail.com",
    description="A Post Installation COnfiguration tool",
    long_description="A Post Installation COnfiguration tool for Linux OSes",
    long_description_content_type="text/plain",
    scripts=["files/pico-wizard-script-runner"],
    entry_points={
        "console_scripts": [
            "pico-wizard = PicoWizard.__main__:__main__",
        ]
    },
    url="https://github.com/pico-wizard/pico-wizard",
    project_urls={
        "Bug Tracker": "https://github.com/pico-wizard/pico-wizard/issues",
        "Documentation": "https://github.com/pico-wizard/pico-wizard",
        "Source Code": "https://github.com/pico-wizard/pico-wizard",
    },
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
    ],
    install_requires=[
        ### Pyside2 needs to be installed from manjaro repository
        ### pip doesnt provide prebuilt arm64
        # "pyside2"
    ],
    python_requires=">=3.6",
    package_data = {
        "": [
            "*.qml",
            "**/*.qml",
            "**/*.svg",
            "**/*.svg.license",
            "**/qmldir",
            "PicoWizard/**/*.svg"
        ]
    },
    include_package_data=True,
) 
