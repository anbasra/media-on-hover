/* ===== UE Hover Image → Video (scoped) ===== */
/* Scope everything to this widget instance */
#{{uc_id}} {
  position: relative;
  display: block;
  width: 100%;
  overflow: hidden;
  /* Important: no background image here to avoid a duplicate request */
  background: none;
  border-radius: 16px;
}

/* --- Cover image stays visible until playback --- */
#{{uc_id}} .ue-image {
  display: block;
  width: 100%;
  height: auto;
  position: relative;
  z-index: 2;
  transition: opacity .25s ease;
  object-fit: cover;
}

/* --- Video layer (initially hidden) --- */
#{{uc_id}} .ue-video {
  position: absolute !important;
  inset: 0 !important;
  width: 100% !important;
  height: 100% !important;
  object-fit: cover;
  z-index: 1;
  opacity: 0;
  pointer-events: none;
  transition: opacity .25s ease;
  background: #000; /* cleaner fade-in on dark scenes */
}

/* --- When playing, reveal video & hide cover --- */
#{{uc_id}}.ue-video-playing .ue-video {
  opacity: 1;
  pointer-events: auto;
}
#{{uc_id}}.ue-video-playing .ue-image {
  opacity: 0;
}

/* --- Desktop hover convenience (kept lightweight) --- */
@media (hover:hover) {
  #{{uc_id}}:hover .ue-video { opacity: 1; pointer-events: auto; }
  #{{uc_id}}:hover .ue-image { opacity: 0; }
}

/* ===== Controls ===== */

/* Play/Pause button — smaller & lower (per your preference) */
#{{uc_id}} .ue-play-toggle {
  position: absolute;
  z-index: 6;
  top: 70%;               /* lower than center so it doesn't cover faces */
  left: 50%;
  transform: translate(-50%, -50%);
  width: 45px;            /* ~30% smaller than default */
  height: 45px;
  border: 0;
  border-radius: 9999px;
  background: rgba(0,0,0,.6);
  color: #fff;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  pointer-events: auto;
  transition: transform .12s ease, opacity .2s ease, background .12s ease;
}
#{{uc_id}} .ue-play-toggle:hover,
#{{uc_id}} .ue-play-toggle:focus-visible {
  background: rgba(0,0,0,.75);
  transform: translate(-50%, -50%) scale(1.05);
  outline: none;
}
#{{uc_id}}.ue-video-playing .ue-play-toggle {
  opacity: 0;
  pointer-events: none;
}

/* Sound toggle (bottom-right corner) */
#{{uc_id}} .ue-sound-toggle {
  position: absolute;
  right: 12px;
  bottom: 12px;
  z-index: 6;
  width: 36px;
  height: 36px;
  border: 0;
  border-radius: 9999px;
  background: rgba(0,0,0,.55);
  color: #fff;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  pointer-events: auto;
  transition: background .12s ease, transform .12s ease;
}
#{{uc_id}} .ue-sound-toggle:hover,
#{{uc_id}} .ue-sound-toggle:focus-visible {
  background: rgba(0,0,0,.75);
  transform: scale(1.05);
  outline: none;
}

/* Show correct icon based on sound state */
#{{uc_id}} .ue-sound-toggle .icon-on { display: none; }
#{{uc_id}}.ue-sound-on .ue-sound-toggle .icon-on { display: inline; }
#{{uc_id}}.ue-sound-on .ue-sound-toggle .icon-off { display: none; }

/* ===== Force icons to WHITE (sound + play) ===== */
#{{uc_id}} .ue-sound-toggle svg,
#{{uc_id}} .ue-sound-toggle svg path,
#{{uc_id}} .ue-sound-toggle svg line,
#{{uc_id}} .ue-sound-toggle svg polygon,
#{{uc_id}} .ue-sound-toggle svg polyline,
#{{uc_id}} .ue-play-toggle svg,
#{{uc_id}} .ue-play-toggle svg path,
#{{uc_id}} .ue-play-toggle svg line,
#{{uc_id}} .ue-play-toggle svg polygon,
#{{uc_id}} .ue-play-toggle svg polyline {
  fill: #fff !important;
  stroke: #fff !important;
}

/* ===== Overlay / optional CTA (if enabled in widget) ===== */
#{{uc_id}} .ue-overlay {
  position: absolute;
  inset: 0;
  z-index: 3;
  pointer-events: none;
  /* subtle top-to-bottom fade, tweak as needed */
  background: linear-gradient(to bottom, rgba(0,0,0,0.15), rgba(0,0,0,0.35));
}
#{{uc_id}} .ue-overlay-icon {
  position: absolute;
  left: 12px;
  top: 12px;
  z-index: 4;
  color: #fff;
  opacity: .95;
}

/* CTA button (if you enable it) */
#{{uc_id}} .ue-button {
  position: absolute;
  left: 12px;
  bottom: 12px;
  z-index: 5;
  padding: 8px 12px;
  font-size: 14px;
  line-height: 1;
  border-radius: 10px;
  color: #fff;
  background: rgba(0,0,0,.55);
  text-decoration: none;
  transition: background .12s ease, transform .12s ease;
}
#{{uc_id}} .ue-button:hover,
#{{uc_id}} .ue-button:focus-visible {
  background: rgba(0,0,0,.75);
  transform: translateY(-1px);
  outline: none;
}

/* ===== Accessibility / duplicates safety ===== */
#{{uc_id}} .ue-play-toggle + .ue-play-toggle,
#{{uc_id}} .ue-sound-toggle + .ue-sound-toggle {
  display: none !important; /* if template accidentally outputs duplicates */
}
#{{uc_id}} .ue-play-toggle:focus-visible,
#{{uc_id}} .ue-sound-toggle:focus-visible,
#{{uc_id}} .ue-button:focus-visible {
  box-shadow: 0 0 0 3px rgba(255,255,255,.35), 0 0 0 5px rgba(0,0,0,.4);
}

/* ===== Reduced motion ===== */
@media (prefers-reduced-motion: reduce) {
  #{{uc_id}} .ue-video,
  #{{uc_id}} .ue-image,
  #{{uc_id}} .ue-play-toggle,
  #{{uc_id}} .ue-sound-toggle,
  #{{uc_id}} .ue-button {
    transition: none !important;
  }
}