# Aarhus Ruby Meetup

Website for the Aarhus Ruby Meetup — a single static page, no build step.

## Run locally

```sh
open public/index.html
# or serve it:
python3 -m http.server -d public 8000
```

## Add a meetup

Edit `public/index.html` and copy a card inside `#meetup-cards` (there's a template in the comment just above it):

```html
<article class="meetup-card" data-date="2026-11-24T17:00">
  <span class="meetup-date">Nov 24</span>
  <div>
    <h3 class="meetup-title">Talk title</h3>
    <p class="meetup-meta">17:00 · <span class="meetup-where">Dentsu Cantine, Åboulevarden 18</span></p>
    <p class="meetup-desc">One or two sentences about the meetup.</p>
  </div>
  <span class="meetup-badge"></span>
</article>
```

`data-date` drives everything: cards are sorted into upcoming/past automatically, and the next upcoming one fills the hero card and the RSVP form.

## RSVPs

The RSVP form posts to [Formspree](https://formspree.io) (form `mojylkgo`); submissions arrive by email.

## Deploy

Render static site, configured in `render.yaml` (publishes `public/`).
