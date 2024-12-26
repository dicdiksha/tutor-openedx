# tutor-openedx

Tutor is a Docker-based distribution of Open edX, designed to simplify the deployment and management of Open edX platforms. Each Tutor version corresponds to a specific Open edX release. Here's a list of Tutor versions and their associated Open edX releases:
```
Tutor Version 10.x.x: Corresponds to Open edX Juniper release.
Tutor Version 11.x.x: Corresponds to Open edX Koa release.
Tutor Version 12.x.x: Corresponds to Open edX Lilac release.
Tutor Version 13.x.x: Corresponds to Open edX Maple release.
Tutor Version 14.x.x: Corresponds to Open edX Nutmeg release.
Tutor Version 15.x.x: Corresponds to Open edX Olive release.
Tutor Version 16.x.x: Corresponds to Open edX Palm release.
Tutor Version 17.x.x: Corresponds to Open edX Quince release.
Tutor Version 18.x.x: Corresponds to Open edX Redwood release.
```
To install a specific version of Tutor that matches a particular Open edX release, you can use the following pip commands:

# Install using bash
```
pip install 'tutor[full]>=10.0.0,<11.0.0'  # For Juniper
pip install 'tutor[full]>=11.0.0,<12.0.0'  # For Koa
pip install 'tutor[full]>=12.0.0,<13.0.0'  # For Lilac
pip install 'tutor[full]>=13.0.0,<14.0.0'  # For Maple
pip install 'tutor[full]>=14.0.0,<15.0.0'  # For Nutmeg
pip install 'tutor[full]>=15.0.0,<16.0.0'  # For Olive
pip install 'tutor[full]>=16.0.0,<17.0.0'  # For Palm
pip install 'tutor[full]>=17.0.0,<18.0.0'  # For Quince
pip install 'tutor[full]>=18.0.0,<19.0.0'  # For Redwood
```
For example, to install Tutor version 11.x.x (which corresponds to Open edX Koa), you would run:

```
pip install 'tutor[full]>=11.0.0,<12.0.0'
```
