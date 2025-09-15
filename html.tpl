<div id="{{uc_id}}" class="ue-hover-image-video" {% if debug_hover_state == "true" and (uc_inside_editor == "yes") %}data-debug="true"{% endif %}>

  <!-- Cover image stays visible until play; lazy by default -->
  <img class="ue-image"
       src="{{image}}"
       alt="{{image_alt}}"
       loading="lazy"
       decoding="async"
       {{image_attributes|ucsafe|raw}}>

  {% if video_source == "html5video" %}
    <!-- We do NOT set src here; we attach it later when in-view/hover -->
    <video class="ue-video"
           preload="none"
           muted
           playsinline
           loop
           poster="{{image}}">
      <source data-src="{% if video_url is not empty %}{{video_url}}{% else %}{{uc_assets_url}}/demo-video.mp4{% endif %}" type="video/mp4" />
    </video>

    <!-- Play button (center) -->
    <button class="ue-play-toggle" type="button" aria-label="Play">
      <span class="ue-play-icon" aria-hidden="true">
        <svg viewBox="0 0 24 24" width="20" height="20"><path d="M8 5v14l11-7z"></path></svg>
      </span>
      <span class="ue-pause-icon" aria-hidden="true" hidden>
        <svg viewBox="0 0 24 24" width="20" height="20"><path d="M6 5h4v14H6zM14 5h4v14h-4z"></path></svg>
      </span>
    </button>

    <!-- Sound toggle (corner) -->
    <button class="ue-sound-toggle" type="button" aria-pressed="false" aria-label="Toggle sound" title="Sound">
      <span class="icon-on" aria-hidden="true">
        <svg viewBox="0 0 24 24" width="18" height="18"><path d="M3 9v6h4l5 4V5L7 9H3z"></path><path d="M14 10a2 2 0 0 1 0 4"></path><path d="M14 7a5 5 0 0 1 0 10"></path><path d="M14 4a8 8 0 0 1 0 16"></path></svg>
      </span>
      <span class="icon-off" aria-hidden="true">
        <svg viewBox="0 0 24 24" width="18" height="18"><path d="M16.5 12l4 4m0-4l-4-4"></path><path d="M3 9v6h4l5 4V5L7 9H3z"></path></svg>
      </span>
    </button>
  {% endif %}

  {% if show_overlay == "true" %}
    <div class="ue-overlay">
      {% if show_overlay_icon == "true" %}
        <span class="ue-overlay-icon" role="img" aria-hidden="true">{{overlay_icon_html|ucsafe|raw}}</span>
      {% endif %}
    </div>
  {% endif %}

  {% if show_button == "true" %}
    <a class="ue-button" href="{{link}}" {{link_html_attributes|ucsafe|raw}}>
      {{button_label|ucsafe|raw}}{% if show_button_icon == "true" %}{{button_icon_html|ucsafe|raw}}{% endif %}
    </a>
  {% endif %}

</div>