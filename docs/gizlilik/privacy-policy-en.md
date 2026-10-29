# Milk Trace — Privacy Policy

> **TASLAK ÇEVİRİ (09.10.2026; 11.10.2026 güncellemesi).** `gizlilik-politikasi.md`'nin (11 Ekim 2026 sürümü) sadık
> İngilizce çevirisi; yayımlamadan önce hukuki kontrolden geçmeli. Türkçe metin
> değişince bu dosya da aynı gün güncellenir. Site `https://milktrace.com.tr/en/privacy`
> adresinde yayımlar (`scripts/sync-legal.sh`). `>` alıntı blokları (bu not) yayımlanmaz.
>
> **18.10.2026:** Türkçe metindeki yardım asistanı (backend ADR 0138, Anthropic) maddeleri
> aynı gün çevrildi.
>
> **19.10.2026:** Türkçe metindeki asistan değişikliği (dış model kalktı, yerel arama)
> aynı gün çevrildi.
>
> **30.10.2026:** KEP adresi ve web adresi (https://albiferro.com) Türkçe metinle aynı gün düzeltildi.

**Last updated:** 30 October 2026

This is an English translation provided for convenience. If it differs from the Turkish
version (https://milktrace.com.tr/gizlilik), the Turkish version prevails.

Milk Trace is a service that lets dairy farms track how much milk each animal gives, using
measurements from the meters at the milking points. This policy describes the personal data
processed through the Milk Trace mobile app, the web panel (milktrace.com.tr) and the demo
request form on the website. The cookies and browser storage used on the website and the web
panel are described in detail in the Cookie Policy (https://milktrace.com.tr/en/cookie-policy).

## 1. Who provides the service

Albiferro Yazılım ve Sistem Limited Şirketi (Albiferro Software & System Limited Company), Atakent Mah. 1472. Cad. No: 5 D: 3, Elvankent, Etimesgut / Ankara, Türkiye; Tax office: Etimesgut, Ankara, Türkiye; tax ID (VKN) 0501474977; MERSİS (Central Registry) No 0050147497700001. Email: info@milktrace.com.tr; registered electronic mail (KEP): albiferroyazilim@hs01.kep.tr; web: https://albiferro.com.

Milk Trace is provided to businesses (farms). The accounts of the people who use the app are
opened on behalf of the business by the platform administrator; accounts cannot be created
from within the app.

## 2. What data we process

**Account information:** full name, email address, role in the business (owner, operator,
viewer), account status. Your password is stored only as an irreversible hash. If you turn
on two-step verification, the verification key is stored encrypted and the backup codes as
irreversible hashes.

**Session information:** the session tokens of the device you signed in on, the
identification of the app/browser that opened the session (user agent) and the IP address
the session was last used from — so that you can recognise and close your devices on the
"Sessions" screen; a session becomes invalid when it is closed or after 30 days at the
latest. Failed password attempts are counted for at most one day using an irreversible hash
of the email and IP address (against guessing attacks). Session tokens are kept in the
operating system's secure storage on your phone, and in your browser's local storage in the
web panel.

**Notification information:** your phone's notification token (Firebase Cloud Messaging)
and platform (Android/iOS), so that you can receive notifications. It is deleted when you
sign out.

**App error reports:** when the app crashes or an unexpected error occurs, the technical
details of the error (stack trace), device model, operating system and app version are sent
to Firebase Crashlytics. Your name, email, business or animal information are not added to
the report; the purpose is to find and fix errors.

**Business data:** the animal records the business enters (ear tag number, name, breed,
birth and calving dates, RFID), milking measurements, alerts and animal notes. Notes show
the name of the user who wrote them. This data belongs to the animals and the business;
apart from notes and author information it does not contain personal data.

**Notification channel recipients:** the email addresses and phone numbers that the
business owner defines to receive alerts.

**Activity log:** for actions that change the business's settings and records (threshold,
animal record, pairing, user, notification channel), who performed the action and when; the
business owner sees it and it is kept for **90 days**.

**Feedback:** the text of the feedback you send from the app, an optional screenshot you
choose, and the automatically added app version, platform, operating system version and
device model; together with your user ID and your business. Only the Milk Trace support team
(platform administrator) sees it; it is used to fix errors and improve the app, and kept for
**1 year**.

**Demo requests:** the name, phone, optional email, farm name and message of people who
fill in the form on the website, together with the IP address and browser information the
form was sent from. Used only to get back to you, kept for **1 year**.

**Subscription payment:** when purchasing a subscription, the business owner enters the
billing title or full name, Turkish ID number (optional for individuals) or tax ID number and
tax office, billing address, email and phone; the order (period, amount, payment result),
the version of the agreement accepted, the moment of acceptance and the IP address are
recorded. **Your card details do not reach us**: you enter your card on the page of the
payment institution PayTR. Billing information is seen only by the business owner and Milk
Trace administrators.

**Help assistant:** if you ask the "Assistant" a question about using the app, your
question, together with your earlier questions in the same conversation, is only searched
for in the help center articles on the Milk Trace server; the answer is the article section
found. The question is not sent to any third party (including any AI service), and your
farm data is not looked at. **The text of questions and answers is not stored**; only a
usage record without any text is kept: the business, the user, the time and the help
article found (to see which topics the assistant helps with).

**Server logs:** for security and debugging, the time, path and result of requests and the
IP address making the request.

**Website measurement (only with your consent):** if you allow "Analytics" in the cookie
banner on the website and the web panel, two measurements run; if you do not, neither is
loaded and no request is sent:

- **Cloudflare Web Analytics** (Cloudflare, Inc., USA): a script is loaded from
  `static.cloudflareinsights.com`; the address of the page visited, the referring page,
  browser type, screen size and page load times are sent to Cloudflare. Your IP address
  reaches Cloudflare with this request; according to Cloudflare it is not used to identify
  visitors. It does not use cookies or local storage.
- **Milk Trace conversion counter** (first party): for events such as submitting the demo
  form (successfully or with an error), or clicking the WhatsApp, phone or Google Play links,
  only the name of the event and its location on the page (e.g. "whatsapp_click", "footer")
  are sent to our server. No name, email, identifier, device information or cookie is sent;
  the server keeps only a total count per event (90 days), not linked to any person. Like
  every other request, the request appears in the server logs (including IP address, 30
  days).

**Strictly necessary cookies and browser storage (no consent needed):** the
`cookie_consent` cookie that stores your cookie choice (policy version, time of choice and
choices; 180 days); your language choice; in the web panel, if you are signed in, the
session refresh token and session marker, theme and screen preferences (in the browser's
local storage). The site is served through Cloudflare; if Cloudflare's bot and attack
protection starts a security check, Cloudflare security cookies (`__cf_bm`,
`cf_clearance`) may be set. No advertising, social media or retargeting cookies are used.
Full list and durations: Cookie Policy (https://milktrace.com.tr/en/cookie-policy).

**What we do not collect:** location, contacts, microphone; photos (other than a screenshot
you choose to attach to feedback); advertising ID; tracking or profiling for advertising.
There are no ads and no usage analytics in the mobile app.

## 3. Why we process it

- To provide the service: sign-in, live milking screen, animal history, reports
  (performance of the contract).
- To alert you: notifications such as a meter fault or a milking summary (performance of the
  contract).
- Security, prevention of misuse and debugging (legitimate interest).
- Help assistant: answering your usage question when you ask it (performance of the
  contract; legitimate interest for the usage record).
- Billing and subscription: price based on the number of lactating animals in the business,
  payment, invoice and end-of-period reminder (performance of the contract; tax legislation
  for billing records).
- Strictly necessary cookies and browser storage: the panel session and the settings you
  ask for (KVKK Art. 5/2-c, establishment and performance of the contract), the security of
  the site and remembering your cookie choice (Art. 5/2-f, legitimate interest).
- Website measurement (Cloudflare Web Analytics and the conversion counter): to understand
  how the site is used and improve it — only with your **explicit consent** (KVKK Art. 5/1);
  you can withdraw it at any time via the "Cookie preferences" link at the bottom of the
  pages.

## 4. Who we share it with

We do not sell data. To provide the service, only with the service providers below and only
as much as necessary:

| Provider | Purpose | Location |
|---|---|---|
| netcup GmbH | server hosting (all data) | Germany |
| Cloudflare, Inc. | delivering the website and the web panel over the network and protecting them against attacks (IP address, request information, a security cookie if needed); Web Analytics only with your consent (page address, referrer, browser, screen, load time) | USA / global |
| Google (Firebase Cloud Messaging) | delivering notifications (notification token, notification text) | USA / EU |
| Google (Firebase Crashlytics) | app error reports (stack trace, device model, version) | USA / EU |
| Twilio SendGrid | email notifications chosen by the business, password reset, payment confirmation and subscription reminder emails (email address, name) | USA |
| PayTR Ödeme ve Elektronik Para Kuruluşu A.Ş. | subscription payment (name/title, email, phone, address, amount; you enter card details directly) | Türkiye |
| Our accountant and e-invoice service provider | issuing the invoice (billing information) | Türkiye |
| NetGSM / İleti Merkezi / JetSMS | SMS (NetGSM: also voice call) notifications chosen by the business (phone number, notification text) | Türkiye |
| Twilio / Vonage | SMS and voice call notifications chosen by the business (phone number, notification text) | USA |
| Open-Meteo | weather forecast for heat stress alerts — our server sends only the facility coordinates entered by the business owner; no personal data is sent | Switzerland (OpenMeteo GmbH) |
| Slack / Microsoft Teams | chat channel notifications chosen by the business (notification text) | USA |
| The business's own mail server (SMTP) or webhook address | notifications defined by the business; the recipient address is the business's choice | wherever the business chooses |

Users of the same business see that business's data according to their roles. Another
business cannot see your business's data.

**Dairy sharing (only with your explicit consent).** If the business owner selects the
dairy they sell their milk to under "Integrations → Dairy sharing" in the app or the web
panel and gives explicit consent, the authorised users of that dairy see the business's
**farm-level** data for the duration of the consent (3 months, 1 year or indefinitely):
business name, total milk quantity and daily trend, average milking flow rate, number of
animals milked, tank deliveries and the next delivery estimate, dairy analysis (fat,
protein, somatic cells, bacteria). Animal names, ear tag numbers, per-animal data, user and
team information are **not shared**. No data goes to any dairy unless consent is given;
consent can be withdrawn at any time with a single tap and takes effect immediately.

## 5. Transfers abroad

The servers are in Germany; some of the notification and email providers and Cloudflare
are in the USA. These transfers are made under Article 9 of the Turkish Personal Data Protection
Law (KVKK) by signing the standard contracts announced by the Personal Data Protection Board
with the recipients and notifying the Board. The transfer abroad of measurement data
collected with Cloudflare Web Analytics is additionally based on the **explicit consent** you
give in the cookie banner (KVKK Art. 5/1 and Art. 9); if you do not consent, this transfer
does not take place.

## 6. How long we keep it

- Account and business data: as long as the business's service contract continues; it is
  deleted automatically **90 days** after the contract ends. During this period, at the
  business owner's request, all of the business's data (animals, milkings, notes, alerts)
  is provided as an Excel file. For billing, only the meter-day records used by the
  business are kept, with the business name anonymised, for the period required by tax
  legislation. Subscription orders, together with billing information, are kept for the
  period required by tax legislation for the same reason.
- Database backups: 7 days (if an off-server copy is used, that copy 14 days); deleted data
  leaves the backups at the latest at the end of this period.
- App error reports: Firebase Crashlytics' retention period (90 days).
- Notification token: deleted on sign-out or when the token becomes invalid.
- Server logs (including IP address): **30 days**.
- Help assistant: the text of questions and answers is **not stored**; only a usage record
  without any text (business, user, time, article found) is kept for **30 days** together
  with the server logs.
- Activity log (who changed what, and when): **90 days**.
- Demo requests: **1 year**.
- Your cookie choice (`cookie_consent`): **180 days**; you are asked again when it expires or
  when the Cookie Policy changes with a new version.
- Conversion counter (only a total count per event): **90 days**. Cloudflare Web Analytics
  data is subject to Cloudflare's retention period.
- Feedback (text, screenshot, device information): **1 year**. If you delete your account,
  the feedback remains but its link to you is removed.

## 7. What is kept on your phone and in your browser

In the mobile app, the session token in the operating system's secure storage; the most
recently viewed data in the app's own storage for offline use. Both are deleted when you
sign out. The mobile app does not use cookies or tracking tools.

In the web panel, the session refresh token and your language and theme preferences are kept
in the browser's local storage; the token is deleted on sign-out. A help assistant
conversation exists only in the memory of the open page: it is erased when you close or
reload the page or press "New conversation". On the website and the web
panel, only the strictly necessary cookies and storage described above and, if you allow it,
analytics measurement are used. You can change your choice at any time via the **"Cookie
preferences"** link at the bottom of every page; details are in the Cookie Policy
(https://milktrace.com.tr/en/cookie-policy).

## 8. Your rights

Under Article 11 of KVKK you have the right to learn whether your data is processed, to
request information, to request its correction or deletion, to object and to request
compensation for damages. Requests: info@milktrace.com.tr or by registered electronic mail
(KEP) to albiferroyazilim@hs01.kep.tr. **You can delete your account
yourself:** in the app, account card → "Delete my account", or at
https://milktrace.com.tr/en/delete-account (with your password). If you are the sole owner
of a business, contact us first so that the business is not left without an owner. When the
account is deleted, your name, email, sessions and notification token are permanently
deleted; the animal notes you wrote remain as the business's herd record and their author
is shown as "Deleted user".

## 9. Children

The service is aimed at businesses; it is not directed at persons under 18.

## 10. Changes

If we change this policy, we publish its current version at this address and announce
significant changes within the app.
