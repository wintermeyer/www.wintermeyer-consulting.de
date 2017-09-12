---
layout: post
title:  HTTP Strict Transport Security (HSTS) Preload Liste
date:   2017-09-12 12:12:00 +0200
author: Stefan Wintermeyer
categories: webperformance
tags:
  - webperformance
  - security
description: >
  Wie kann man seine eigene Webseite auf die HSTS-Preload-Liste von Chrome, Firefox, Opera, Safari, IE 11 und Edge bekommen? Eine Schritt für Schritt Anleitung.
---
Auch wenn es in Deutschland immer noch viele unverschlüsselte Webseiten gibt (HTTP), geht kein Weg an HTTPS vorbei. Alleine schon um ein besseres Google-Ranking zu bekommen.

Es reicht aber nicht, nur HTTPS parallel zu HTTP anzubieten. Aus
Security-Sicht ist es notwendig nur noch HTTPS anzubieten und alle Anfragen auf HTTP direkt nach HTTPS umzuleiten. Und mit HTTP Strict Transport Security (HSTS) geht man noch einen Schritt weiter: Wenn dem Browser bekannt ist, das eine bestimmte Webseite nur per HTTPS angesprochen werden kann, dann kann er selbstständig HTTP-Anfragen auf HTTPS umstellen. Dadurch lassen sich man-in-the-middle-Attacken wie die in ["New Tricks For Defeating SSL In Practice"](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security#cite_note-14) besprochene Variante verhindern. Bei der HSTS-Preload-List hält der Browser eine entsprechende Liste von Domain-Namen vor. Er weiß somit, das Anfragen auf wintermeyer-consulting.de und allen Unterdomains auf jeden Fall per HTTPS geschehen müssen. Egal was der User oder eine Mailware eingibt. Als Bonus bekommt man noch einen Tick mehr WebPerformance, weil man sich den Redirect spart.

## Wie kommt man auf diese Liste?

Als erstes muss man seine Webserver-Konfiguration so anpassen, das immer der Header `Strict-Transport-Security: max-age=63072000; includeSubDomains; preload` mitgegeben wird. Damit ist dem Webbrowser klar, das diese Domain und alle Subdomains nur per HTTPS ansprechbar sind. Ist dies geschehen, kann man auf  https://hstspreload.org beantragen auf die HSTS-Preload-Liste von Chrome aufgenommen zu werden. Die gleiche Liste wird auch von  Firefox, Opera, Safari, IE 11 und Edge benutzt.

Das Eintragen in die Liste dauert im Schnitt 24-48 Stunden. Danach werden beim nächsten Update alle Browser mit dem Eintrag bestückt. Den Status kann man auf der gleichen Webseite abfragen.

![Screenshot](/assets/2017/09/12/hstspreload-screenshot.png "HSTS-Preload-Seite Screenshot")

**Wichtig:** Es ist relativ einfach auf die HSTS-Preload-Liste zu kommen. Der umgekehrte Weg ist schwieriger und zeitaufwendiger, da man ja nicht einfach die Einträge per Fingerschnipp auf allen installierten Browsern revoken kann. Man muss also ganz sicher sein, das nicht doch irgend eine API der eigene Webseite von irgend einem Kunden nur per HTTP angefragt werden kann (warum auch immer). Entweder alles HTTPS oder kein Eintrag in der HSTS-Preload-Liste!

## Nginx-Beispiel-Konfiguration

Neben dem `Strict-Transport-Security: max-age=63072000; includeSubDomains; preload` Header muss sichergestellt werden, das Anfragen auf http://firma.de auf https://firma.de und Anfragen auf http://www.firma.de auf https://www.firma.de umgeleitet werden. Dabei ist zu beachten, das http://firma.de nicht direkt auf https://www.firma.de umgeleitet werden darf.

Die entsprechende Nginx-Konfiguration ist aber recht einfach. Ein Beispiel:

```
# Virtual Host configuration for www.firma.de
#
server {
	listen 80;
	server_name www.firma.de;

	root /var/www/www.firma.de;
	index  index.html index.htm;

	location / {
	  rewrite ^/(.*)$ https://www.firma.de/$1 permanent;
	  rewrite ^/$ https://www.firma.de/ permanent;
	}
}

server {
	listen 80;
	server_name firma.de;

	root /var/www/www.firma.de;
	index  index.html index.htm;

	location / {
	  rewrite ^/(.*)$ https://firma.de/$1 permanent;
	  rewrite ^/$ https://firma.de/ permanent;
	}
}

server {
	listen 443 ssl http2;
	server_name firma.de;

  # Letsencrypt SSL certificate
	ssl_certificate     /etc/letsencrypt/live/www.firma.de/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/www.firma.de/privkey.pem;

	# Connection credentials caching
	ssl_session_cache shared:SSL:20m;
	ssl_session_timeout 180m;

	# Strict Transport Security
	# => Tell the client to remember that this is a https site
  add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;

	root /var/www/www.firma.de;
	index  index.html index.htm;

	location / {
	  rewrite ^/(.*)$ https://www.firma.de/$1 permanent;
	  rewrite ^/$ https://www.firma.de/ permanent;
	}
}

server {
	listen 443 ssl http2;
	server_name www.firma.de;

  # Letsencrypt SSL certificate
	ssl_certificate     /etc/letsencrypt/live/www.firma.de/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/www.firma.de/privkey.pem;

	# Connection credentials caching
	ssl_session_cache shared:SSL:20m;
	ssl_session_timeout 180m;

	# Strict Transport Security
	# => Tell the client to remember that this is a https site
  add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;

	root /var/www/www.firma.de;
	index  index.html index.htm;

	location / {
	  try_files $uri $uri/ =404;
	}
}
```

## Links

- [https://hstspreload.org](https://hstspreload.org)
- [https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security)
- [https://www.chromium.org/hsts](https://www.chromium.org/hsts)
