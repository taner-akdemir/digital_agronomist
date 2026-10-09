# Milk Trace — Privacy Policy

> **TASLAK ÇEVİRİ (09.10.2026).** `gizlilik-politikasi.md`'nin (1 Ekim 2026 sürümü) sadık
> İngilizce çevirisi; yayımlamadan önce hukuki kontrolden geçmeli. Türkçe metin
> değişince bu dosya da aynı gün güncellenir. Site `https://milktrace.com.tr/en/privacy`
> adresinde yayımlar (`scripts/sync-legal.sh`). `>` alıntı blokları (bu not) yayımlanmaz.

**Last updated:** 1 October 2026

This is an English translation provided for convenience. If it differs from the Turkish
version (https://milktrace.com.tr/gizlilik), the Turkish version prevails.

Milk Trace is a service that lets dairy farms track how much milk each animal gives, using
measurements from the meters at the milking points. This policy describes the personal data
processed through the Milk Trace mobile app, the web panel (milktrace.com.tr) and the demo
request form on the website.

## 1. Who provides the service

Algebran Soft (Taner Akdemir, sole proprietorship), Atakent Mah. 1472. Cad. Eda Apt. No: 5 D: 3, Elvankent, Etimesgut / Ankara, Türkiye (Etimesgut Tax Office). Contact: info@milktrace.com.tr.

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

**Server logs:** for security and debugging, the time, path and result of requests and the
IP address making the request.

**What we do not collect:** location, contacts, microphone; photos (other than a screenshot
you choose to attach to feedback); advertising ID; usage analytics or tracking for
advertising. There are no ads in the app.

## 3. Why we process it

- To provide the service: sign-in, live milking screen, animal history, reports
  (performance of the contract).
- To alert you: notifications such as a meter fault or a milking summary (performance of the
  contract).
- Security, prevention of misuse and debugging (legitimate interest).
- Billing and subscription: price based on the number of lactating animals in the business,
  payment, invoice and end-of-period reminder (performance of the contract; tax legislation
  for billing records).

## 4. Who we share it with

We do not sell data. To provide the service, only with the service providers below and only
as much as necessary:

| Provider | Purpose | Location |
|---|---|---|
| netcup GmbH | server hosting (all data) | Germany |
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

The servers are in Germany; some of the notification and email providers are in the USA.
These transfers are made under Article 9 of the Turkish Personal Data Protection Law (KVKK)
by signing the standard contracts announced by the Personal Data Protection Board with the
recipients and notifying the Board.

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
- Activity log (who changed what, and when): **90 days**.
- Demo requests: **1 year**.
- Feedback (text, screenshot, device information): **1 year**. If you delete your account,
  the feedback remains but its link to you is removed.

## 7. What is kept on your phone

The session token in the operating system's secure storage; the most recently viewed data
in the app's own storage for offline use. Both are deleted when you sign out. In the web
panel, the session refresh token and your language and theme preferences are kept in the
browser's local storage; no cookies or tracking tools are used. The token is deleted on
sign-out.

## 8. Your rights

Under Article 11 of KVKK you have the right to learn whether your data is processed, to
request information, to request its correction or deletion, to object and to request
compensation for damages. Requests: info@milktrace.com.tr. **You can delete your account
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
