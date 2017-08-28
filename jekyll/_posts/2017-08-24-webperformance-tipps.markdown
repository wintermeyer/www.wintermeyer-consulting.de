---
layout: post
title:  "5 WebPerformance Tipps für deutsche Webseiten"
date:   2017-08-24 10:27:41 +0200
author: Stefan Wintermeyer
categories: webperformance
tags:
  - webperformance
description: >
  Schritte für eine optimale WebPerformance deutscher Webseiten. HTTP/2 und QUIC sind erst der Anfang. Schneller = Besseres Google-Ranking.
---
WebPerformance ist ein schwieriges Thema. Man fängt halt sehr selten auf der grünen Wiese an. Die meisten Webseiten sind über Jahre gewachsen. Immer mehr Funktionalität ist hinzugekommen und damit ist die Seite auch immer langsamer geworden. Irgendwann liest aber jemand im Marketing oder im Vorstand, das Google schnelle Webseiten besser rankt und dann soll auf einmal alles schnell "gemacht" werden. Am besten über Nacht. Mit einem besseren Google-Ranking bekommt man jeden. ;-)

*So viel vor Weg: Wenn es einfach wäre, dann könnte ich dafür kein [Consulting](/webperformance) verkaufen. WebPerformance-Optimierung ist ein Full-Stack-Thema.*

In diesem Post zeige ich Ihnen die 5 häufigsten Probleme bei deutschen Webseiten und wie sie beseitigt werden können. Ich gehe dabei nicht all zu tief auf die technischen Hintergründe ein. Wenn Sie sich mehr einlesen wollen, dann empfehle ich Ihnen meinen [iX-Artikel zu dem Thema WebPerformance](http://www.heise.de/ix/inhalt/2015/8/102/) und das Buch [High Performance Browser Networking](https://hpbn.co). Bei Fragen können Sie mir gerne eine E-Mail an sw@wintermeyer-consulting.de schreiben oder mich unter Tel. 0261-9886803 anrufen.

### Webserver in Frankfurt

Man soll es nicht glauben, aber die Netzwerkdistanz vom Webserver zum Browser ist wichtig. Das liegt hauptsächlich am TCP-Slow-Start und daran, das Lichtgeschwindigkeit "nur" 299.792.458 m/s schnell ist. Eine Webseite von einem (billigen?) Webserver in den USA lädt immer langsamer als die gleiche Webseite von einem Server in Deutschland. Und wenn wir von Deutschland sprechen, dann sprechen wir von Frankfurt. Da läuft alles zusammen und es liegt für Deutschland netzwerktechnisch in der Mitte.

Ach ja, bitte testen Sie Ihre Webseiten nicht nur vom und im Intranet. Da sind die Netzwerkstrecken besonders kurz. Das verfälscht den Eindruck. Extrem!

### HTTP/2

Die meisten deutschen Webseiten werden noch mit dem HTTP/1.1 Protokoll ausgeliefert. Das hat uns sicherlich viele Jahr gute Dienste geleistet, aber heute will man Webseiten mit dem HTTP/2 Protokoll ausliefern. Alleine diese Umstellung führt im Schnitt zu 20% schnelleren Webseiten.

Nach der Umstellung muss man das aber dann auch regelmässig auf den wichtigsten Browsern testen. Ich kenne Firmen, die schon vor langer Zeit auf HTTP/2 umgestellt haben, dann hat sich aber was im Chrome-Browser geändert (lange Geschichte) und auf einmal war die Seite vom Chrome nur noch per HTTP/1.1 erreichbar. Hat natürlich keiner gemerkt.

Streber können übrigens auch [QUIC](https://www.chromium.org/quic) installieren. Da muss man sich aber schon sehr gut mit dem Betriebssystem, der Firewall und dem Webserver auskennen.

### CDNs oder etwa doch nicht?

Jahrelang hat man gesagt, das das Ausliefern von Grafiken via externem CDNs wichtig für eine gute WebPerformance sind. Stimmt das etwas nicht mehr? Nein, es stimmt nicht mehr. Wenn Sie eine Webseite via HTTP/2 ausliefern, dann ist es immer besser **alle** Elemente dieser Webseite auch vom gleichen Server (also der schon offenen TCP-Verbindung) auszuliefern.

CDNs machen nur bei der Verwendung von HTTP/1.1 Sinn. Und das wollen wir ja nicht mehr, weil eh langsamer.

Ausnahme 1: Wenn Ihre Kunden weltweit auf Ihre Webseite zugreifen und sie nur einen Webserver (egal ob geclustert oder nicht) haben. Dann kann die Verwendung eines guten CDNs (z.B. [fastly.com](https://www.fastly.com)) Sinn machen, um die Distanz vom Browser zum Server (dann dem CDN als Proxy) zu verkürzen. Wenn Sie aber hauptsächlich von Zugriffen aus Deutschland und DACH leben, dann stellen Sie auf HTTP/2 um und kündigen Sie Ihr CDN. Geld gespart und schnellere Webseite!

Ausnahme 2: Sollten Sie zu einem bestimmten Zeitpunkt mehrere Millionen Zugriffe bekommen, weil Sie z.B. eine neue Software zum Download anbieten, dann kann ein CDN eine große Hilfe zur Vermeidung eines DOS sein.

### Grafiken

Es wird keinen verwundern, das eine kleine Grafik schnelle übertragen wird, als eine große Grafik. Und doch werden auf den aller wenigsten Webseiten die Grafiken optimal ausgeliefert.

* Wenn die Grafik mit 100x100 Pixeln angezeigt wird, dann muss man sie nicht mit 200x200 Pixeln ausliefern. Das ist Bandbreitenverschwendung und verbraucht unnötig CPU-Leistung auf dem Browser (gerade bei Handys ein Thema).
* Ob JPEG, PNG oder GIF ist eigentlich egal. Hauptsache man versteht die Vor- und Nachteile der jeweiligen Formate und benutzt immer das ideale Format. Falls man gar nicht weiter weiß, exportiert man ein Bild in alle drei Formate und schaut sie sich dann an.
* Auf jeden Fall ist immer ein Besuch von [kraken.io](https://kraken.io) oder ähnlichen Webseiten sinnvoll. Dort kann man Grafiken automatisch optimieren lassen. Natürlich kann jemand, der viel Ahnung von der Materie hat, das in Handarbeit noch besser, aber so ein Server ist eine gute 80% Lösung und besser als gar nichts.

Ich weiß wie trival das Thema daher kommt. Aber bis jetzt habe ich noch bei jedem neuen WebPerformance-Kunden Optimierungsmöglichkeiten bei Grafiken gefunden.

### Schriften

Sie kennen das: Man lädt eine Webseiten und nach 1-3 Sekunden verändert sich die Schrift und das Layout. Alles ruckelt. So was nervt und es führt zu einer schlechteren WebPerformance. So bald Sie eine externe Schrift laden, verschlechtern Sie die Ladezeit der Webseite! Die meisten Webseiten können auch mit den bereits im Browser verfügbaren Schriften sehr gut dargestellt werden.

### Weniger ist mehr ... äh, ... schneller

Egal ob HTML, CSS, Schriften oder JavaScript. Je weniger sie ausliefern, desto schneller wird diese Payload ausgeliefert und desto weniger Arbeit hat der Browser mit der Webseite. Das muss vom Browser alles gerendet werden. Das JavaScript muss kompiliert werden. Das dauert alles und summiert sich. **Kleinvieh macht bei der WebPerformance verdammt viel Mist.**

Diese Seite ist komprimiert weniger als 28 KB groß und damit schnell ausgeliefert. Warum 28 KB? 1460 * 20 / 1024 sind ungefähr 28. Das ist die maximale Kapazität des zweiten TCP-Paketes auf dieser Verbindung. Das erste Paket wird für den SSL-Schlüssel benutzt. Aber jetzt werde ich doch wieder zu technisch.

Wichtig: Was nicht unbedingt gebraucht wird, muss raus.

### Was ist mit AMP?

Jetzt habe ich die wichtigsten 5 Punkte schon abgearbeitet. [AMP](https://www.ampproject.org) ist ein komplexes Thema. Das werde ich in einem extra Posting behandeln.

## Wie teste ich die WebPerformance?

Sehr gute Frage! Die wirkliche Performance können Sie nicht mit dem Entwicklungs-System oder mit Staging testen. Das sind alles erste wichtige Schritte, aber am Ende des Tages, müssen Sie die Performance auf Ihrem Produktionssystem testen. Am allerbesten mal LTE auf dem Handy ausschalten, den Cache leeren und dann schauen wie langsam oder schnell die Webseite auf dem Handy lädt.

Wenn Sie etwas tiefer einsteigen wollen, empfehle ich Ihnen die Webseite einmal mit [webpagetest.org](https://www.webpagetest.org) zu testen.

**Achtung:** Der größte Fehler ist ein lokaler Test mit einem gefüllten Cache im Browser. Damit ist jede Webseite schneller. Zum Thema Cache werden ich auch mal was posten. Das ist aber ein eigenes großes Thema.

## Ich das alles?

Nein, aber es ist ein Anfang. Damit können Sie Ihre Webseite schon mal ein gutes Stück schneller machen. Im Schnitt hat bringt jede Sekunde schnellere Ladezeit ein 5%ig Verbesserung in der Conversion-Rate.

**Bonus:** Ein besseres Google-Ranking!
