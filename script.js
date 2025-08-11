// ——— Einstellungen ———
const DEFAULTS = {
  work: 25 * 60,   // 25 Minuten
  rest: 5 * 60     // 5 Minuten
};

// ——— Zustand ———
let mode = "work";                   // "work" | "rest"
let remainingSeconds = DEFAULTS.work;
let running = false;
let endAt = null;                    // Zeitstempel (ms), wenn die aktuelle Phase endet
let timeoutId = null;

// ——— DOM ———
const timerDisplay = document.getElementById("timer");
const beep = document.getElementById("beep");

// ——— Helpers ———
function formatMMSS(totalSeconds) {
  const m = Math.floor(totalSeconds / 60);
  const s = totalSeconds % 60;
  return `${String(m).padStart(2, "0")}:${String(s).padStart(2, "0")}`;
}

function updateDisplay() {
  timerDisplay.textContent = formatMMSS(remainingSeconds);
}

function scheduleNextTick() {
  // exakt auf den nächsten Sekundensprung timen
  const msLeft = endAt - Date.now();
  const msToNext = msLeft % 1000 || 1000;
  timeoutId = setTimeout(tick, msToNext);
}

function switchPhase() {
  // Sound (falls erlaubt)
  try { beep && beep.play?.(); } catch {}
  mode = mode === "work" ? "rest" : "work";
  remainingSeconds = mode === "work" ? DEFAULTS.work : DEFAULTS.rest;
  endAt = Date.now() + remainingSeconds * 1000;
  updateDisplay();
}

function tick() {
  if (!running) return;

  // Restzeit präzise ausrechnen
  const secs = Math.max(0, Math.round((endAt - Date.now()) / 1000));
  if (secs !== remainingSeconds) {
    remainingSeconds = secs;
    updateDisplay();
  }

  if (remainingSeconds <= 0) {
    switchPhase();
  }

  if (running) scheduleNextTick();
}

// ——— Steuerung ———
function startTimer() {
  if (running) return;
  running = true;

  // falls vorher pausiert war, endAt neu setzen
  if (!endAt) {
    endAt = Date.now() + remainingSeconds * 1000;
  }
  scheduleNextTick();
}

function pauseTimer() {
  if (!running) return;
  running = false;
  clearTimeout(timeoutId);
  timeoutId = null;
  // Restzeit konservieren
  remainingSeconds = Math.max(0, Math.round((endAt - Date.now()) / 1000));
  endAt = null;
  updateDisplay();
}

function resetTimer() {
  running = false;
  clearTimeout(timeoutId);
  timeoutId = null;
  mode = "work";
  remainingSeconds = DEFAULTS.work;
  endAt = null;
  updateDisplay();
}

// ——— Events ———
document.getElementById("start").addEventListener("click", startTimer);
document.getElementById("pause").addEventListener("click", pauseTimer);
document.getElementById("reset").addEventListener("click", resetTimer);

// initiales Rendern
updateDisplay();
