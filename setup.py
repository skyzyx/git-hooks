from setuptools import setup

setup(
    name='pre_commit_placeholder_package',
    version='0.0.0',
    install_requires=[
        'checkov==2.1.32',
        'ruamel.yaml==0.17.21',
        'yamllint==1.26.3',
        'yapf==0.32.0',
    ],
)
