#import "/templates/post.typ": post
#import "/utils/helpers.typ" as utils

#let args = (
    title: "stop your ThinkPad from dozing off",
    date: "2025-09-15",
    author: "amy erskine",
    summary: [modern standby and its consequences],
    tags: ("tidbits", "windows"),
)

#show: post.with(..args)

With modern Windows devices comes Modern Sleep/Standby. Whilst great in theory, we still haven't gotten to the point of slick mobile-like flows you might find on Android/iOS. 
This means that the device locking itself when you glance away is terribly inconvenient, and so users rightly complain.

There's several Windows services that control this, depending on the firmware/model. Disable any of the ones you find:
- Virtual Lock Sensor
- Elliptic Human Presence Detection Service
- Lenovo Smart Standby
- Lenovo Intelligent Sensing

You may also have to disable it in Lenovo *Commercial* Vantage.


