---
title: stop your ThinkPad from dozing off
description: modern standby and its consequences
permalink: posts/{{ title | slugify }}/index.html
date: '2025-09-15'
tags: [windows, tidbits]
---
With modern Windows devices comes Modern Sleep/Standby. Whilst great in theory, we still haven't gotten to the point of slick mobile-like flows
you might find on Android/iOS. This means that the device locking itself when you glance away is terribly inconvenient, and so users rightly complain.

There's several Windows services that control this, depending on the firmware/model. Disable any of the ones you find:
- Virtual Lock Sensor
- Elliptic Human Presence Detection Service
- Lenovo Smart Standby
- Lenovo Intelligent Sensing

You may also have to disable it in Lenovo **Commercial** Vantage.

