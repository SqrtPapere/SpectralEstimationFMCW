# SpectralEstimationFMCW
Application of Non-Parametric Spectral Estimation techniques on FMCW Signals

----

- Obiettivo: ricostruire in un dominio tempo-frequenza il segnale proveniente da un radar FMCW (Frequency-Modulated Continuous-Wave)
- Tecnica: metodi non parametrici
- Analisi di segnale chirp per valutare la bontà dei metodi

I metodi implementati sono in linguaggio **Matlab** e prevedono funzioni che calcolano il *periodogramma*, il *periodogramma modificato*, il *periodogramma di Welch-Bartlet* e il *periodogramma di Blackman-Tukey*. I risultati vengono valutati con la stampa a video dei grafici ricostruiti ponendo attenzione alla risoluzione di questi.

## Radar

Il funzionamento di un radar è basato sulla trasmissione di un segnale e sulla misura del ritardo che impiega per ritornare dopo essere stato riflesso da un oggetto (bersaglio), tale ritardo diviso per due e moltiplicato per la velocità della luce dà una stima della distanza dell’oggetto.
Se si usa un impulso non modulato, la risoluzione, cioè la capacità di discriminare due oggetti ad una certa distanza tra loro, è legata alla durata dell’impulso trasmesso. Viceversa, se si utilizzano particolari modulazioni, come ad esempio la modulazione lineare di frequenza, è possibile, tramite opportune elaborazioni del segnale, ottenere risoluzioni migliori. La risoluzione dipende infatti dalla banda (B) del segnale e non dalla sua durata, ed è pari circa ad 1/B.
Esistono due tipi di radar continuos-wave: *unmodulated continuous-wave* e *modulated continuous-wave*.

## Unmodulated continuous-wave

In questo tipo di radar si invia un segnale sinusoidale continuo ad una certa frequenza con l’idea che lo stesso segnale rimbalzando su un oggetto, possa subire degli slittamenti in frequenza dovuti all’effetto **Doppler** generato dall’oggetto in movimento. Con questo tipo di radar non c’è modo di determinare la distanza dell’oggetto infatti è usato in sport come golf, tennis, baseball e corse automobilistiche.
La variazione in frequenza dovuta al Doppler dipende dalla velocità *c’* della luce nell’aria (*c’* poichè è leggermente più lenta che nel vuoto) e da *v* la velocità dell’oggetto target:


![f1.png](/img/f1.png)
