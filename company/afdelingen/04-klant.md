# Klant
strip: ok | customer-support geïnstalleerd
meta: actief binnen 48 uur en blijven

## Doel
Een chauffeur is binnen 48 uur actief en blijft.

## Meetlat
Activatie (eerste bon binnen 48 uur), reactietijd support, churn.

## Ritme
`ma 08:00` weekbericht · `dagelijks` support binnen 4 werkuren

## Skills
| Skill | Detail | Bron | Status | Beoordelen |
|---|---|---|---|---|
| customer-support | triage, antwoorden, escalatie, KB-artikelen | anthropics/knowledge-work-plugins | ok: geïnstalleerd 3 sep | 17 sep (E3) |
| weekbericht, helpdesk-AI, onboarding-drip | in de bot | Whatsapp-bot | own: eigen code | live |
| her-uitnodiging wagenpark | chauffeurs op stap new of invited tonen als Uitgenodigd; knop per rij en per wagenpark stuurt de fleet_invite-template (24 uur cooldown, slot per fleet, 409 zolang de template geen SID heeft); stap new gaat in de webhook naar de wagenpark-welkom | Whatsapp-bot | own: gebouwd 4 sep, wacht op deploy en Meta | 7 dagen na de eerste ronde (E12) |
| onleesbare bon | foto blijft aan de alert hangen; typt of spreekt de chauffeur de bon binnen 2 uur in, dan koppelt de bot de foto en sluit de alert zelf; anders vult een medewerker hem in vanuit de admin | Whatsapp-bot | own: live 4 sep (PR #21, #23) | 1 okt (E6) |
