<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Under Maintenance — EBikes Duniya</title>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800;900&family=DM+Sans:opsz,wght@9..40,300;9..40,400;9..40,500;9..40,600&display=swap" rel="stylesheet"/>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>

<style>
/* ══════════════════════════════════════════════════════
   EBIKES DUNIYA — MAINTENANCE PAGE
   Dark Gradient SaaS UI · Full immersive experience
   ══════════════════════════════════════════════════════ */

*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }
html { height:100%; font-size:16px; }

:root {
  --void:    #030608;
  --bg:      #060c16;
  --cyan:    #00d4ff;
  --blue:    #3b82f6;
  --orange:  #f97316;
  --green:   #10b981;
  --yellow:  #f59e0b;
  --red:     #ef4444;
  --t1:      #edf2ff;
  --t2:      #7a90b8;
  --t3:      #2e4060;
  --bdr:     rgba(255,255,255,0.07);
  --card-bg: rgba(255,255,255,0.032);
  --fh:      'Outfit',  sans-serif;
  --fb:      'DM Sans', sans-serif;
  --ease:    cubic-bezier(0.4,0,0.2,1);
  --spring:  cubic-bezier(0.34,1.56,0.64,1);
}

body {
  font-family: var(--fb);
  background: var(--bg);
  color: var(--t1);
  min-height: 100vh;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  -webkit-font-smoothing: antialiased;
  position: relative;
}

/* ══ DEEP SPACE BACKGROUND ══════════════════════════ */
.bg-layer {
  position: fixed; inset: 0; pointer-events: none; z-index: 0;
}

/* Radial mesh */
.bg-mesh {
  position: fixed; inset: 0; z-index: 0; pointer-events: none;
  background:
    radial-gradient(ellipse 80% 60% at 20% 10%,  rgba(0,212,255,0.055) 0%, transparent 55%),
    radial-gradient(ellipse 60% 50% at 80% 80%,  rgba(59,130,246,0.045) 0%, transparent 55%),
    radial-gradient(ellipse 50% 40% at 50% 50%,  rgba(249,115,22,0.025) 0%, transparent 55%),
    radial-gradient(ellipse 100% 100% at 50% 50%, rgba(3,6,8,0.96) 40%, transparent 100%);
}

/* Animated dot grid */
.bg-grid {
  position: fixed; inset: 0; z-index: 0; pointer-events: none;
  background-image:
    radial-gradient(circle, rgba(0,212,255,0.18) 1px, transparent 1px);
  background-size: 44px 44px;
  animation: gridDrift 25s linear infinite;
  opacity: 0.5;
  mask-image: radial-gradient(ellipse 90% 90% at 50% 50%, black 0%, transparent 100%);
}
@keyframes gridDrift {
  0%   { background-position: 0 0; }
  100% { background-position: 44px 44px; }
}

/* CRT scanline overlay */
.bg-scanlines {
  position: fixed; inset: 0; z-index: 0; pointer-events: none;
  background: repeating-linear-gradient(
    0deg,
    transparent,
    transparent 3px,
    rgba(0,0,0,0.06) 3px,
    rgba(0,0,0,0.06) 4px
  );
}

/* ══ FLOATING PARTICLES ═════════════════════════════ */
.particles { position: fixed; inset: 0; z-index: 1; pointer-events: none; overflow: hidden; }
.pt {
  position: absolute; border-radius: 50%;
  animation: ptRise linear infinite;
}
@keyframes ptRise {
  0%   { transform: translateY(105vh) translateX(0) scale(0);   opacity: 0; }
  8%   { opacity: 1; transform: translateY(90vh)  translateX(0) scale(1); }
  92%  { opacity: 0.6; }
  100% { transform: translateY(-10vh) translateX(var(--dx)) scale(0.5); opacity: 0; }
}

/* ══ MAIN CARD ══════════════════════════════════════ */
.card {
  position: relative; z-index: 10;
  width: min(660px, 94vw);
  background: rgba(8,15,30,0.85);
  border: 1px solid var(--bdr);
  border-radius: 26px;
  padding: clamp(32px,5vw,56px) clamp(24px,5vw,60px) clamp(28px,4vw,44px);
  backdrop-filter: blur(32px) saturate(160%);
  -webkit-backdrop-filter: blur(32px) saturate(160%);
  box-shadow:
    0 0 0 1px rgba(0,212,255,0.05),
    0 60px 120px rgba(0,0,0,0.7),
    0 24px 48px rgba(0,0,0,0.5),
    inset 0 1px 0 rgba(255,255,255,0.06),
    inset 0 -1px 0 rgba(0,0,0,0.3);
  text-align: center;
  animation: cardEntrance 1s var(--spring) both;
  overflow: visible;
}
@keyframes cardEntrance {
  0%   { opacity:0; transform: translateY(40px) scale(0.95); }
  100% { opacity:1; transform: translateY(0)    scale(1); }
}

/* Top glow line */
.card::before {
  content: '';
  position: absolute; top: 0; left: 8%; right: 8%; height: 1px;
  background: linear-gradient(90deg, transparent, rgba(0,212,255,0.7), rgba(59,130,246,0.8), rgba(0,212,255,0.7), transparent);
  border-radius: 99px;
}

/* Bottom glow */
.card::after {
  content: '';
  position: absolute; bottom: -1px; left: 20%; right: 20%; height: 1px;
  background: linear-gradient(90deg, transparent, rgba(0,212,255,0.2), transparent);
}

/* ══ STATUS PILL ════════════════════════════════════ */
.status-pill {
  position: absolute; top: -1px; left: 50%; transform: translateX(-50%);
  display: inline-flex; align-items: center; gap: 7px;
  padding: 5px 16px 5px 10px;
  background: rgba(245,158,11,0.1);
  border: 1px solid rgba(245,158,11,0.28);
  border-radius: 99px;
  font-size: 11.5px; font-weight: 700; color: var(--yellow);
  letter-spacing: 0.5px; text-transform: uppercase;
  backdrop-filter: blur(12px);
  white-space: nowrap;
  animation: pillBounce 0.7s var(--spring) 0.1s both;
}
@keyframes pillBounce {
  0%   { opacity:0; transform: translateX(-50%) translateY(-10px) scale(0.8); }
  100% { opacity:1; transform: translateX(-50%) translateY(0)      scale(1); }
}
.pill-dot {
  width: 7px; height: 7px; border-radius: 50%;
  background: var(--yellow);
  box-shadow: 0 0 8px var(--yellow);
  animation: pillPulse 1.6s ease-in-out infinite;
}
@keyframes pillPulse {
  0%,100% { opacity:1; transform: scale(1); }
  50%      { opacity:0.35; transform: scale(0.75); }
}

/* ══ LOGO ═══════════════════════════════════════════ */
.logo {
  display: inline-flex; align-items: center; gap: 10px;
  margin-bottom: 28px;
  animation: slideDown 0.6s var(--ease) 0.15s both;
}
@keyframes slideDown {
  0%   { opacity:0; transform: translateY(-14px); }
  100% { opacity:1; transform: translateY(0); }
}
.logo-orb {
  width: 38px; height: 38px; border-radius: 11px; flex-shrink: 0;
  background: linear-gradient(145deg, #ff7c38, #e84300);
  display: flex; align-items: center; justify-content: center;
  box-shadow: 0 4px 20px rgba(249,115,22,0.4), inset 0 1px 0 rgba(255,255,255,0.2);
  animation: orbSpin 0.5s var(--spring) 0.3s both;
}
@keyframes orbSpin {
  0%   { transform: rotate(-20deg) scale(0.7); }
  100% { transform: rotate(0)      scale(1); }
}
.logo-orb svg { width: 19px; height: 19px; fill: white; }
.logo-name  { font-family: var(--fh); font-size: 17px; font-weight: 800; color: var(--t1); letter-spacing: -0.3px; }
.logo-accent{ color: var(--cyan); }

/* ══ ANIMATED ELECTRIC BIKE SVG ══════════════════════ */
.bike-scene {
  width: 240px; height: 120px; margin: 0 auto 26px;
  position: relative;
  animation: fadeUp 0.7s var(--ease) 0.2s both;
}

/* Road line */
.road-line {
  position: absolute; bottom: 0; left: 0; right: 0; height: 2px;
  background: linear-gradient(90deg, transparent, rgba(0,212,255,0.3), rgba(59,130,246,0.3), transparent);
  border-radius: 99px;
  overflow: hidden;
}
.road-line::after {
  content: '';
  position: absolute; top: 0; left: -100%; width: 60%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(0,212,255,0.8), transparent);
  animation: roadRide 2s linear infinite;
}
@keyframes roadRide { 100% { left: 200%; } }

/* Speed lines */
.speed-lines {
  position: absolute; left: 0; top: 50%; transform: translateY(-50%);
  display: flex; flex-direction: column; gap: 8px;
  animation: speedAnim 1.2s linear infinite;
  opacity: 0.35;
}
@keyframes speedAnim {
  0%   { transform: translateY(-50%) translateX(0);   opacity: 0.35; }
  100% { transform: translateY(-50%) translateX(-40px); opacity: 0; }
}
.sl { height: 1.5px; background: linear-gradient(90deg, transparent, var(--cyan)); border-radius: 2px; }

/* Bike SVG */
.bike-svg {
  position: absolute;
  bottom: 8px; right: 10px;
  animation: bikeHover 3s ease-in-out infinite;
  filter: drop-shadow(0 8px 20px rgba(0,212,255,0.15));
}
@keyframes bikeHover {
  0%,100% { transform: translateY(0); }
  50%      { transform: translateY(-5px); }
}

/* Electric spark on wheel */
.wheel-spark {
  position: absolute; bottom: 22px;
  width: 8px; height: 8px;
  animation: sparkAnim 0.8s ease-in-out infinite;
}
.spark-1 { right: 53px; }
.spark-2 { right: 108px; }
@keyframes sparkAnim {
  0%,100% { opacity: 0; transform: scale(0.4); }
  50%      { opacity: 1; transform: scale(1); }
}

/* ══ HEADLINE ════════════════════════════════════════ */
@keyframes fadeUp {
  0%   { opacity:0; transform: translateY(16px); }
  100% { opacity:1; transform: translateY(0); }
}

.headline {
  font-family: var(--fh);
  font-size: clamp(26px, 4.5vw, 40px);
  font-weight: 900;
  letter-spacing: -1.5px;
  line-height: 1.08;
  background: linear-gradient(135deg, #ffffff 0%, #c8e8ff 40%, var(--cyan) 75%, var(--blue) 100%);
  -webkit-background-clip: text; -webkit-text-fill-color: transparent;
  background-clip: text;
  margin-bottom: 12px;
  animation: fadeUp 0.7s var(--ease) 0.25s both;
}
.headline em {
  font-style: normal;
  background: linear-gradient(90deg, var(--orange), #fb923c);
  -webkit-background-clip: text; -webkit-text-fill-color: transparent;
  background-clip: text;
}

.tagline {
  font-size: 14.5px; color: var(--t2); line-height: 1.72;
  max-width: 420px; margin: 0 auto 30px;
  animation: fadeUp 0.7s var(--ease) 0.32s both;
}
.tagline strong { color: var(--t1); font-weight: 600; }

/* ══ COUNTDOWN ═══════════════════════════════════════ */
.countdown {
  display: grid; grid-template-columns: repeat(4,1fr);
  gap: 10px; margin: 0 auto 26px; max-width: 400px;
  animation: fadeUp 0.7s var(--ease) 0.38s both;
}
.cd-box {
  background: var(--card-bg);
  border: 1px solid var(--bdr);
  border-radius: 13px;
  padding: 14px 8px 11px;
  position: relative; overflow: hidden;
  transition: border-color 0.25s;
}
.cd-box::before {
  content: '';
  position: absolute; top: 0; left: 0; right: 0; height: 2px;
  background: linear-gradient(90deg, var(--cyan), var(--blue));
  border-radius: 99px 99px 0 0;
}
.cd-box:hover { border-color: rgba(0,212,255,0.2); }
.cd-n {
  font-family: var(--fh);
  font-size: clamp(26px,4vw,38px);
  font-weight: 900; color: var(--t1);
  line-height: 1; display: block;
  letter-spacing: -1.5px;
  transition: transform 0.15s;
}
.cd-n.flip { animation: cdFlip 0.2s ease; }
@keyframes cdFlip {
  0%   { transform: translateY(-6px); opacity: 0.4; }
  100% { transform: translateY(0);    opacity: 1; }
}
.cd-l {
  font-size: 10px; font-weight: 600;
  color: var(--t3); letter-spacing: 1.8px;
  text-transform: uppercase; margin-top: 5px;
  display: block;
}

/* ══ PROGRESS ════════════════════════════════════════ */
.prog-section {
  max-width: 400px; margin: 0 auto 24px;
  animation: fadeUp 0.7s var(--ease) 0.44s both;
}
.prog-header {
  display: flex; justify-content: space-between; align-items: center;
  font-size: 12px; color: var(--t3); margin-bottom: 9px; letter-spacing: 0.3px;
}
.prog-header strong { color: var(--cyan); font-weight: 700; font-size: 13px; }
.prog-track {
  height: 7px; background: rgba(255,255,255,0.06);
  border-radius: 99px; overflow: visible; position: relative;
}
.prog-fill {
  height: 100%; border-radius: 99px; position: relative;
  background: linear-gradient(90deg, var(--cyan) 0%, var(--blue) 100%);
  box-shadow: 0 0 14px rgba(0,212,255,0.4);
  transition: width 1.8s cubic-bezier(0.4,0,0.2,1);
  animation: progGrow 2s cubic-bezier(0.4,0,0.2,1) 0.8s both;
}
.prog-fill::after {
  content: '';
  position: absolute; right: -1px; top: 50%; transform: translateY(-50%);
  width: 14px; height: 14px; border-radius: 50%;
  background: var(--cyan);
  box-shadow: 0 0 12px rgba(0,212,255,0.8), 0 0 24px rgba(0,212,255,0.4);
  animation: dotPulse 1.2s ease-in-out infinite;
}
@keyframes progGrow { 0%{ width:0; } 100%{ width:72%; } }
@keyframes dotPulse {
  0%,100% { box-shadow: 0 0 10px rgba(0,212,255,0.7), 0 0 20px rgba(0,212,255,0.3); }
  50%      { box-shadow: 0 0 18px rgba(0,212,255,1),   0 0 36px rgba(0,212,255,0.5); }
}

/* ══ TASK LIST ═══════════════════════════════════════ */
.tasks {
  display: flex; flex-direction: column; gap: 7px;
  max-width: 400px; margin: 0 auto 26px;
  animation: fadeUp 0.7s var(--ease) 0.50s both;
}
.task-row {
  display: flex; align-items: center; gap: 11px;
  padding: 9px 13px; border-radius: 10px;
  background: rgba(255,255,255,0.025);
  border: 1px solid rgba(255,255,255,0.055);
  font-size: 13px; color: var(--t2);
  transition: border-color 0.2s, background 0.2s;
}
.task-row.s-done   { border-color: rgba(16,185,129,0.1);  }
.task-row.s-active { border-color: rgba(0,212,255,0.18); background: rgba(0,212,255,0.045); color: var(--t1); }
.task-row.s-queue  { opacity: 0.6; }
.task-icon {
  width: 26px; height: 26px; border-radius: 7px; flex-shrink: 0;
  display: flex; align-items: center; justify-content: center;
  font-size: 11px;
}
.s-done   .task-icon { background: rgba(16,185,129,0.12); color: var(--green); }
.s-active .task-icon { background: rgba(0,212,255,0.1);   color: var(--cyan); }
.s-queue  .task-icon { background: rgba(255,255,255,0.04); color: var(--t3); }
.task-label { flex: 1; font-weight: 500; }
.task-badge {
  font-size: 10px; font-weight: 700; padding: 2px 9px;
  border-radius: 99px; letter-spacing: 0.4px; text-transform: uppercase; flex-shrink: 0;
}
.s-done   .task-badge { background: rgba(16,185,129,0.1);  color: var(--green); }
.s-active .task-badge { background: rgba(0,212,255,0.1);   color: var(--cyan); animation: badgeBlink 1.8s ease-in-out infinite; }
.s-queue  .task-badge { background: rgba(255,255,255,0.05); color: var(--t3); }
@keyframes badgeBlink { 0%,100%{opacity:1;} 50%{opacity:0.45;} }

/* ══ NOTIFY FORM ══════════════════════════════════════ */
.notify-section {
  max-width: 400px; margin: 0 auto 24px;
  animation: fadeUp 0.7s var(--ease) 0.56s both;
}
.notify-label {
  font-size: 12.5px; color: var(--t3); margin-bottom: 9px;
  display: flex; align-items: center; gap: 6px; justify-content: center;
}
.notify-label i { color: var(--cyan); font-size: 11px; }
.notify-pill {
  display: flex; align-items: center; gap: 0;
  background: rgba(255,255,255,0.03);
  border: 1px solid var(--bdr); border-radius: 12px;
  padding: 4px 4px 4px 14px;
  transition: border-color 0.22s, box-shadow 0.22s;
}
.notify-pill:focus-within {
  border-color: rgba(0,212,255,0.35);
  box-shadow: 0 0 0 3px rgba(0,212,255,0.07);
}
.notify-pill.err {
  border-color: rgba(239,68,68,0.5);
  box-shadow: 0 0 0 3px rgba(239,68,68,0.07);
  animation: shake 0.4s ease;
}
@keyframes shake {
  0%,100%{transform:translateX(0);}
  25%{transform:translateX(-6px);}
  75%{transform:translateX(6px);}
}
.notify-pill input {
  flex: 1; background: none; border: none; outline: none;
  font-family: var(--fb); font-size: 13.5px; color: var(--t1);
  min-width: 0;
}
.notify-pill input::placeholder { color: var(--t3); }
.notify-btn {
  display: flex; align-items: center; gap: 7px;
  padding: 9px 18px; border-radius: 9px;
  background: linear-gradient(135deg, var(--cyan), var(--blue));
  color: #020a14; font-family: var(--fh); font-size: 13px; font-weight: 800;
  border: none; cursor: pointer; white-space: nowrap; flex-shrink: 0;
  transition: transform 0.2s var(--spring), opacity 0.2s, box-shadow 0.2s;
  box-shadow: 0 4px 14px rgba(0,212,255,0.2);
}
.notify-btn:hover  { transform: translateY(-1px); box-shadow: 0 7px 22px rgba(0,212,255,0.32); }
.notify-btn:active { transform: translateY(0); }
.notify-btn i { font-size: 11px; }

/* Success state */
.notify-success {
  display: none; align-items: center; justify-content: center; gap: 9px;
  padding: 12px 16px; border-radius: 12px;
  background: rgba(16,185,129,0.07);
  border: 1px solid rgba(16,185,129,0.2);
  color: var(--green); font-size: 13.5px; font-weight: 500;
  animation: fadeUp 0.4s var(--spring) both;
}
.notify-success i { font-size: 16px; }

/* ══ SOCIAL STRIP ════════════════════════════════════ */
.social-strip {
  display: flex; align-items: center; justify-content: center;
  gap: 8px; margin-bottom: 24px;
  animation: fadeUp 0.7s var(--ease) 0.62s both;
}
.social-label { font-size: 12px; color: var(--t3); margin-right: 4px; }
.soc {
  width: 34px; height: 34px; border-radius: 9px;
  background: rgba(255,255,255,0.035);
  border: 1px solid var(--bdr);
  display: flex; align-items: center; justify-content: center;
  color: var(--t2); font-size: 14px; text-decoration: none;
  transition: all 0.2s var(--spring);
}
.soc:hover {
  background: rgba(0,212,255,0.1);
  border-color: rgba(0,212,255,0.3);
  color: var(--cyan);
  transform: translateY(-3px) scale(1.08);
  box-shadow: 0 6px 18px rgba(0,212,255,0.18);
}

/* ══ FOOTER ══════════════════════════════════════════ */
.card-footer {
  border-top: 1px solid rgba(255,255,255,0.05);
  padding-top: 18px;
  display: flex; align-items: center; justify-content: center;
  gap: 14px; flex-wrap: wrap;
  font-size: 12px; color: var(--t3);
  animation: fadeUp 0.7s var(--ease) 0.68s both;
}
.card-footer a {
  color: var(--t3); text-decoration: none;
  display: flex; align-items: center; gap: 4px;
  transition: color 0.18s;
}
.card-footer a:hover { color: var(--cyan); }
.card-footer a i { font-size: 10px; }
.foot-sep { color: rgba(255,255,255,0.1); user-select: none; }

/* ══ ORBITING DECORATION ══════════════════════════════ */
.orbit-ring {
  position: fixed; border-radius: 50%;
  border: 1px solid rgba(0,212,255,0.06);
  pointer-events: none; z-index: 0;
  top: 50%; left: 50%;
  transform: translate(-50%, -50%);
  animation: orbitExpand 4s ease-in-out infinite;
}
.or-1 { width: 400px; height: 400px; animation-delay: 0s; }
.or-2 { width: 650px; height: 650px; animation-delay: 1.5s; border-color: rgba(59,130,246,0.04); }
.or-3 { width: 950px; height: 950px; animation-delay: 3s;   border-color: rgba(0,212,255,0.025); }
@keyframes orbitExpand {
  0%,100% { transform: translate(-50%,-50%) scale(1);    opacity: 1; }
  50%      { transform: translate(-50%,-50%) scale(1.04); opacity: 0.6; }
}

/* ══ FLOATING BOLT ═══════════════════════════════════ */
.float-bolt {
  position: fixed; pointer-events: none; z-index: 2;
  color: rgba(0,212,255,0.14); font-size: 22px;
  animation: boltFloat linear infinite;
}
@keyframes boltFloat {
  0%   { transform: translateY(0) rotate(-10deg); opacity: 0; }
  10%  { opacity: 1; }
  90%  { opacity: 0.7; }
  100% { transform: translateY(-100vh) rotate(20deg); opacity: 0; }
}

/* ══ RESPONSIVE ══════════════════════════════════════ */
@media(max-width:520px){
  .countdown { grid-template-columns: repeat(2,1fr); gap: 8px; }
  .card-footer gap { gap: 10px; }
  .social-strip { flex-wrap: wrap; }
}
@media(max-width:380px){
  .notify-pill { flex-direction: column; padding: 8px 12px; gap: 8px; }
  .notify-btn  { width: 100%; justify-content: center; }
}
</style>
</head>
<body>

<!-- ── BACKGROUNDS ── -->
<div class="bg-mesh"></div>
<div class="bg-grid"></div>
<div class="bg-scanlines"></div>

<!-- ── ORBIT RINGS ── -->
<div class="orbit-ring or-1"></div>
<div class="orbit-ring or-2"></div>
<div class="orbit-ring or-3"></div>

<!-- ── PARTICLES ── -->
<div class="particles" id="particles"></div>

<!-- ══════════════════════════════════════════════════
     MAIN CARD
══════════════════════════════════════════════════ -->
<div class="card" id="mainCard">

  <!-- Status Pill -->
  <div class="status-pill">
    <div class="pill-dot"></div>
    Scheduled Maintenance
  </div>

  <!-- Logo -->
  <div class="logo">
    <div class="logo-orb">
      <svg viewBox="0 0 24 24"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/></svg>
    </div>
    <span class="logo-name">EBikes<span class="logo-accent"> Duniya</span></span>
  </div>

  <!-- Animated Bike Scene -->
  <div class="bike-scene">
    <!-- Speed lines on left -->
    <div class="speed-lines">
      <div class="sl" style="width:55px"></div>
      <div class="sl" style="width:38px;margin-left:10px"></div>
      <div class="sl" style="width:48px;margin-left:5px"></div>
      <div class="sl" style="width:30px;margin-left:14px"></div>
    </div>

    <!-- Electric Bike SVG -->
    <svg class="bike-svg" width="190" height="105" viewBox="0 0 190 105" fill="none" xmlns="http://www.w3.org/2000/svg">
      <!-- Rear wheel -->
      <circle cx="42" cy="78" r="24" stroke="rgba(0,212,255,0.6)" stroke-width="6" fill="none"/>
      <circle cx="42" cy="78" r="6"  fill="rgba(0,212,255,0.5)"/>
      <!-- Spokes -->
      <line x1="42" y1="54" x2="42" y2="102" stroke="rgba(0,212,255,0.25)" stroke-width="1.5"/>
      <line x1="18" y1="78" x2="66"  y2="78"  stroke="rgba(0,212,255,0.25)" stroke-width="1.5"/>
      <line x1="25" y1="61" x2="59"  y2="95"  stroke="rgba(0,212,255,0.15)" stroke-width="1.5"/>
      <line x1="59" y1="61" x2="25"  y2="95"  stroke="rgba(0,212,255,0.15)" stroke-width="1.5"/>

      <!-- Front wheel -->
      <circle cx="148" cy="78" r="24" stroke="rgba(0,212,255,0.6)" stroke-width="6" fill="none"/>
      <circle cx="148" cy="78" r="6"  fill="rgba(0,212,255,0.5)"/>
      <!-- Spokes -->
      <line x1="148" y1="54" x2="148" y2="102" stroke="rgba(0,212,255,0.25)" stroke-width="1.5"/>
      <line x1="124" y1="78" x2="172" y2="78"  stroke="rgba(0,212,255,0.25)" stroke-width="1.5"/>
      <line x1="131" y1="61" x2="165" y2="95"  stroke="rgba(0,212,255,0.15)" stroke-width="1.5"/>
      <line x1="165" y1="61" x2="131" y2="95"  stroke="rgba(0,212,255,0.15)" stroke-width="1.5"/>

      <!-- Frame -->
      <path d="M66,78 L90,38 L130,38 L148,78" stroke="rgba(255,255,255,0.75)" stroke-width="5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
      <line x1="42" y1="78" x2="90" y2="38" stroke="rgba(255,255,255,0.55)" stroke-width="4" stroke-linecap="round"/>

      <!-- Seat post -->
      <line x1="100" y1="38" x2="100" y2="18" stroke="rgba(255,255,255,0.7)" stroke-width="4" stroke-linecap="round"/>
      <!-- Seat -->
      <rect x="84" y="12" width="38" height="9" rx="4.5" fill="rgba(255,255,255,0.6)"/>

      <!-- Handle bars -->
      <line x1="130" y1="38" x2="140" y2="18" stroke="rgba(255,255,255,0.7)" stroke-width="4" stroke-linecap="round"/>
      <line x1="130" y1="18" x2="155" y2="18" stroke="rgba(255,255,255,0.5)" stroke-width="3.5" stroke-linecap="round"/>

      <!-- Battery box -->
      <rect x="90" y="40" width="40" height="22" rx="5" fill="rgba(0,212,255,0.18)" stroke="rgba(0,212,255,0.5)" stroke-width="1.5"/>
      <rect x="128" y="46" width="4" height="10" rx="2" fill="rgba(0,212,255,0.5)"/>

      <!-- Lightning bolt on battery -->
      <path d="M107,44 L101,54 L106,54 L99,64 L112,51 L107,51 Z" fill="rgba(0,212,255,0.9)"/>

      <!-- Headlight glow -->
      <ellipse cx="168" cy="68" rx="12" ry="7" fill="rgba(0,212,255,0.08)"/>
      <circle  cx="166" cy="68" r="4" fill="rgba(0,212,255,0.5)"/>
      <path d="M170,68 Q185,62 190,58" stroke="rgba(0,212,255,0.3)" stroke-width="2" stroke-linecap="round" fill="none"/>
      <path d="M170,68 Q185,68 190,66" stroke="rgba(0,212,255,0.2)" stroke-width="1.5" stroke-linecap="round" fill="none"/>
    </svg>

    <!-- Spark dots on wheels -->
    <div class="wheel-spark spark-1">
      <svg width="8" height="8" viewBox="0 0 8 8"><circle cx="4" cy="4" r="3" fill="rgba(0,212,255,0.9)"/></svg>
    </div>
    <div class="wheel-spark spark-2">
      <svg width="8" height="8" viewBox="0 0 8 8"><circle cx="4" cy="4" r="3" fill="rgba(249,115,22,0.9)"/></svg>
    </div>

    <!-- Road -->
    <div class="road-line"></div>
  </div>

  <!-- Headline -->
  <h1 class="headline">We're <em>Charging Up</em><br/>For Something Better</h1>

  <p class="tagline">
    <strong>EBikes Duniya</strong> is undergoing scheduled maintenance to deliver you a faster, more powerful platform.
    We'll be back in full charge — very soon! ⚡
  </p>

  <!-- LIVE COUNTDOWN -->
  <div class="countdown">
    <div class="cd-box">
      <span class="cd-n" id="cdH">24</span>
      <span class="cd-l">Hours</span>
    </div>
    <div class="cd-box">
      <span class="cd-n" id="cdM">00</span>
      <span class="cd-l">Minutes</span>
    </div>
    <div class="cd-box">
      <span class="cd-n" id="cdS">00</span>
      <span class="cd-l">Seconds</span>
    </div>
    <div class="cd-box" style="background:rgba(0,212,255,0.04);border-color:rgba(0,212,255,0.15)">
      <span class="cd-n" style="background:linear-gradient(135deg,var(--cyan),var(--blue));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text">72%</span>
      <span class="cd-l" style="color:rgba(0,212,255,0.5)">Done</span>
    </div>
  </div>

  <!-- PROGRESS BAR -->
  <div class="prog-section">
    <div class="prog-header">
      <span>System Restoration Progress</span>
      <strong>72% Complete</strong>
    </div>
    <div class="prog-track">
      <div class="prog-fill" style="width:72%"></div>
    </div>
  </div>

  <!-- TASK LIST -->
  <div class="tasks">
    <div class="task-row s-done">
      <div class="task-icon"><i class="fa fa-check"></i></div>
      <span class="task-label">Database migration &amp; backup</span>
      <span class="task-badge">Done</span>
    </div>
    <div class="task-row s-done">
      <div class="task-icon"><i class="fa fa-check"></i></div>
      <span class="task-label">Server infrastructure upgrade</span>
      <span class="task-badge">Done</span>
    </div>
    <div class="task-row s-active">
      <div class="task-icon"><i class="fa fa-circle-notch fa-spin"></i></div>
      <span class="task-label">Deploying new UI &amp; features</span>
      <span class="task-badge">In Progress</span>
    </div>
    <div class="task-row s-queue">
      <div class="task-icon"><i class="fa fa-hourglass-half"></i></div>
      <span class="task-label">Security patches &amp; final QA</span>
      <span class="task-badge">Queued</span>
    </div>
  </div>

  <!-- NOTIFY FORM -->
  <div class="notify-section">
    <p class="notify-label">
      <i class="fa fa-bell"></i>
      Notify me when EBikes Duniya is back
    </p>

    <div class="notify-pill" id="nPill">
      <input type="email" id="nEmail" placeholder="Enter your email address…"/>
      <button class="notify-btn" onclick="doNotify()">
        <i class="fa fa-bolt"></i>Notify Me
      </button>
    </div>

    <div class="notify-success" id="nSuccess">
      <i class="fa fa-circle-check"></i>
      You're on the list! We'll notify you the moment we're live.
    </div>
  </div>

  <!-- SOCIAL -->
  <div class="social-strip">
    <span class="social-label">Stay updated:</span>
    <a href="#" class="soc" title="Twitter/X"><i class="fab fa-x-twitter"></i></a>
    <a href="#" class="soc" title="Instagram"><i class="fab fa-instagram"></i></a>
    <a href="#" class="soc" title="WhatsApp"><i class="fab fa-whatsapp"></i></a>
    <a href="#" class="soc" title="YouTube"><i class="fab fa-youtube"></i></a>
    <a href="#" class="soc" title="Telegram"><i class="fab fa-telegram"></i></a>
  </div>

  <!-- FOOTER -->
  <div class="card-footer">
    <span>© 2026 EBikes Duniya</span>
    <span class="foot-sep">·</span>
    <a href="mailto:info@ebikesduniya.com"><i class="fa fa-envelope"></i>info@ebikesduniya.com</a>
    <span class="foot-sep">·</span>
    <a href="tel:+919001234567"><i class="fa fa-phone"></i>+91 90012 34567</a>
    <span class="foot-sep">·</span>
    <a href="#">Privacy Policy</a>
  </div>

</div><!-- /card -->

<!-- ══════════════════════════════════════════════════
     JAVASCRIPT
══════════════════════════════════════════════════ -->
<script>
'use strict';

/* ─── Countdown ───────────────────────────────────── */

var endTime = Date.now() + (24 * 3600 * 1000); // 24 hours only
var prevVals = { h:null, m:null, s:null };

function tick() {
  var diff = Math.max(0, endTime - Date.now());
  var h = Math.floor(diff / 3600000);
  var m = Math.floor((diff % 3600000) / 60000);
  var s = Math.floor((diff % 60000) / 1000);

  function set(id, val, key) {
    var el = document.getElementById(id);
    var str = String(val).padStart(2, '0');
    if (prevVals[key] !== val) {
      el.classList.remove('flip');
      void el.offsetWidth; // reflow
      el.classList.add('flip');
      prevVals[key] = val;
    }
    el.textContent = str;
  }
  set('cdH', h, 'h');
  set('cdM', m, 'm');
  set('cdS', s, 's');

  if (diff > 0) setTimeout(tick, 1000);
}
tick();

/* ─── Email Notify ────────────────────────────────── */
function doNotify() {
  var pill  = document.getElementById('nPill');
  var input = document.getElementById('nEmail');
  var succ  = document.getElementById('nSuccess');
  var val   = input.value.trim();

  if (!val || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val)) {
    pill.classList.remove('err');
    void pill.offsetWidth;
    pill.classList.add('err');
    setTimeout(function() { pill.classList.remove('err'); }, 800);
    input.focus();
    return;
  }

  // Simulate API call
  pill.style.transition = 'opacity 0.3s';
  pill.style.opacity = '0';
  setTimeout(function() {
    pill.style.display = 'none';
    succ.style.display = 'flex';
  }, 300);
}

document.getElementById('nEmail').addEventListener('keydown', function(e) {
  if (e.key === 'Enter') doNotify();
});

/* ─── Particles ───────────────────────────────────── */
var container = document.getElementById('particles');
var colors = ['rgba(0,212,255,', 'rgba(59,130,246,', 'rgba(249,115,22,', 'rgba(255,255,255,'];

for (var i = 0; i < 32; i++) {
  var el   = document.createElement('div');
  el.className = 'pt';
  var left = Math.random() * 100;
  var dur  = 10 + Math.random() * 16;
  var del  = -(Math.random() * dur);
  var size = 1.5 + Math.random() * 2.5;
  var col  = colors[Math.floor(Math.random() * colors.length)];
  var opa  = (0.2 + Math.random() * 0.55).toFixed(2);
  var dx   = (Math.random() - 0.5) * 140;

  el.style.cssText = [
    'left:' + left + 'vw',
    'bottom:-4px',
    'width:' + size + 'px',
    'height:' + size + 'px',
    'background:' + col + opa + ')',
    'animation-duration:' + dur + 's',
    'animation-delay:' + del + 's',
    '--dx:' + dx + 'px'
  ].join(';');

  container.appendChild(el);
}

/* ─── Floating Bolt Icons ─────────────────────────── */
var boltPositions = [
  { left:'8%',  dur:14, del:0   },
  { left:'22%', dur:18, del:5   },
  { left:'75%', dur:12, del:3   },
  { left:'88%', dur:20, del:9   },
  { left:'50%', dur:16, del:7   },
];
boltPositions.forEach(function(b) {
  var el = document.createElement('i');
  el.className = 'fa fa-bolt float-bolt';
  el.style.cssText = 'left:' + b.left + ';bottom:-30px;animation-duration:' + b.dur + 's;animation-delay:-' + b.del + 's;';
  el.style.fontSize = (16 + Math.random() * 14) + 'px';
  document.body.appendChild(el);
});
</script>
</body>
</html>
