{{ ucfunc("put_docready_start") }}

  (function($){
    var $container = $("#{{uc_id}}");
    var $videoEl   = $container.find(".ue-video");
    if (!$videoEl.length || $videoEl.get(0).tagName.toLowerCase() !== "video") return;

    // --- GLOBAL REGISTRY (fixes the typo) ---
    window.__uehv_instances = window.__uehv_instances || [];
    var registry = window.__uehv_instances;

    // Buttons (keep only one of each)
    var $playBtn  = $container.find(".ue-play-toggle").first();
    $container.find(".ue-play-toggle").not($playBtn).remove();

    var $soundBtn = $container.find(".ue-sound-toggle").first();
    $container.find(".ue-sound-toggle").not($soundBtn).remove();

    var video           = $videoEl.get(0);
    var id              = $container.attr("id");
    var playing         = false;
    var soundEnabled    = false;  // toggled by user
    var userInteracted  = false;  // becomes true after first gesture

    // Attach <source src> only when needed
    function ensureLoaded(){
      if (video.dataset.loaded === "1") return;
      var srcEl = video.querySelector('source[data-src]');
      if (!srcEl) { video.dataset.loaded = "1"; return; }
      srcEl.setAttribute("src", srcEl.getAttribute("data-src"));
      srcEl.removeAttribute("data-src");
      // Keep muted for mobile autoplay; do not start download until load() is called
      video.muted = true;
      video.defaultMuted = true;
      video.load(); // now the browser will fetch metadata (not full file)
      video.dataset.loaded = "1";
    }

    // Register this instance so only one plays at a time
    var me = {
      id: id,
      stop: function(){
        if (!playing) return;
        video.pause();
        try { video.currentTime = 0; } catch(e){}
        $container.removeClass("ue-video-playing");
        playing = false;
      }
    };
    registry.push(me);

    function setMuted(val){
      video.muted = val;
      video.defaultMuted = val;
      if (val) video.setAttribute("muted",""); else video.removeAttribute("muted");
      $container.toggleClass("ue-sound-on", !val);
      if ($soundBtn.length) $soundBtn.attr("aria-pressed", (!val) ? "true" : "false");
    }

    function applyMuteState(){
      var shouldBeMuted = !(userInteracted && soundEnabled);
      setMuted(shouldBeMuted);
    }

    function pauseOthers(){
      for (var i=0;i<registry.length;i++){
        if (registry[i].id !== id){ registry[i].stop(); }
      }
    }

    function startPlay(){
      // Ensure src is attached just-in-time
      ensureLoaded();
      pauseOthers();
      applyMuteState();
      try { video.currentTime = 0; } catch(e){}
      return video.play().then(function(){
        $container.addClass("ue-video-playing");
        playing = true;
      }).catch(function(err){
        // Autoplay will succeed after any user gesture
        // console.log("Autoplay blocked:", err);
      });
    }

    function stopPlay(){ me.stop(); }

    // First real gesture enables audio later
    window.addEventListener("pointerdown", function(){ userInteracted = true; }, { once:true });

    // Hover play on desktop only
    var supportsHover = window.matchMedia && window.matchMedia("(hover:hover)").matches;
    if (supportsHover){
      $container.on("mouseenter", function(){ startPlay(); });
      $container.on("mouseleave", function(){ stopPlay(); });
    } else {
      // Mobile/Tablet: tap anywhere (except controls) toggles play
      $container.on("click", function(e){
        if ($(e.target).closest(".ue-sound-toggle, .ue-play-toggle, a, button").length) return;
        if (!playing) startPlay(); else stopPlay();
      });
    }

    // Play button
    if ($playBtn.length){
      $playBtn.on("click", function(e){
        e.preventDefault(); e.stopPropagation();
        userInteracted = true;
        if (!playing) startPlay(); else stopPlay();
      });
    }

    // Sound button
    if ($soundBtn.length){
      $soundBtn.on("click", function(e){
        e.preventDefault(); e.stopPropagation();
        soundEnabled = !soundEnabled;
        userInteracted = true; // counts as gesture
        applyMuteState();
        if (playing){ video.play().catch(function(){}); }
      });
    }

    // Attach src ONLY when the card is near/in view (no network before this)
    if ("IntersectionObserver" in window){
      var io = new IntersectionObserver(function(entries){
        entries.forEach(function(entry){
          if (entry.isIntersecting){
            ensureLoaded();         // attach src + load metadata now
            io.unobserve($container.get(0));
          }
        });
      }, { rootMargin: "300px", threshold: 0.25 });
      io.observe($container.get(0));

      // Also auto-pause when scrolled out of view
      var stopIO = new IntersectionObserver(function(entries){
        entries.forEach(function(entry){
          if (!entry.isIntersecting && playing) stopPlay();
        });
      }, { threshold: 0.35 });
      stopIO.observe($container.get(0));
    }

    // Initial: muted so first tap can autoplay inline (iOS)
    setMuted(true);
  })(jQuery);

{{ ucfunc("put_docready_end") }}