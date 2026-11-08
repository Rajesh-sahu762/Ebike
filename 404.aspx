
<%@ Page Language="C#" %>
<%
    Response.StatusCode = 404;
    Response.StatusDescription = "Page Not Found";
    Response.TrySkipIisCustomErrors = true;
    Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
    Response.Cache.SetNoStore();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<title>404 | EBikes Duniya</title>
<meta name="robots" content="noindex, nofollow" />

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html, body {
    width: 100%;
    height: 100%;
    overflow: hidden;
}

body {
    font-family: "Segoe UI", Arial, sans-serif;
    color: #f8fafc;
    background: #050d19;
}

.scene {
    position: relative;
    width: 100%;
    height: 100vh;
    height: 100svh;
    min-height: 480px;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    isolation: isolate;
    padding: 18px;
    background:
        radial-gradient(ellipse at 50% 45%, rgba(8,145,178,.18), transparent 52%),
        radial-gradient(circle at 10% 15%, rgba(249,115,22,.12), transparent 30%),
        radial-gradient(circle at 90% 85%, rgba(34,211,238,.10), transparent 30%),
        #050d19;
}

/* Animated ambient background */
.ambient {
    position: absolute;
    inset: -30%;
    z-index: -2;
    background: conic-gradient(
        from 0deg,
        transparent,
        rgba(8,145,178,.10),
        transparent,
        rgba(249,115,22,.08),
        transparent
    );
    filter: blur(65px);
    animation: ambientRotate 24s linear infinite;
}

@keyframes ambientRotate {
    to { transform: rotate(360deg); }
}

/* Grid */
.grid-bg {
    position: absolute;
    inset: 0;
    z-index: -1;
    opacity: .15;
    background-image:
        linear-gradient(rgba(34,211,238,.18) 1px, transparent 1px),
        linear-gradient(90deg, rgba(34,211,238,.18) 1px, transparent 1px);
    background-size: 55px 55px;
    mask-image: radial-gradient(ellipse, black, transparent 75%);
}

/* Floating particles */
.particles {
    position: absolute;
    inset: 0;
    pointer-events: none;
}

.particle {
    position: absolute;
    width: 4px;
    height: 4px;
    border-radius: 50%;
    background: #22d3ee;
    box-shadow: 0 0 12px #22d3ee;
    animation: floatParticle 7s ease-in-out infinite;
}

.particle:nth-child(1) { left: 12%; top: 20%; }
.particle:nth-child(2) { left: 82%; top: 16%; animation-delay: -2s; }
.particle:nth-child(3) { left: 75%; top: 75%; animation-delay: -4s; }
.particle:nth-child(4) { left: 20%; top: 78%; animation-delay: -1s; }
.particle:nth-child(5) { left: 48%; top: 10%; animation-delay: -3s; }
.particle:nth-child(6) { left: 92%; top: 48%; animation-delay: -5s; }

@keyframes floatParticle {
    0%, 100% { transform: translateY(0) scale(.7); opacity: .25; }
    50% { transform: translateY(-35px) scale(1.5); opacity: 1; }
}

.content {
    width: 100%;
    max-width: 760px;
    text-align: center;
    position: relative;
    z-index: 2;
    animation: appear .8s ease both;
}

@keyframes appear {
    from { opacity: 0; transform: translateY(24px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Brand logo */
.brand {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    margin-bottom: clamp(10px, 2vh, 20px);
}

.brand img {
    display: block;
    width: clamp(145px, 22vw, 205px);
    height: clamp(48px, 8vh, 70px);
    object-fit: contain;
    filter: drop-shadow(0 0 16px rgba(34,211,238,.18));
}

/* 404 */
.error-number {
    position: relative;
    font-size: clamp(105px, 18vw, 175px);
    font-weight: 950;
    letter-spacing: -.09em;
    line-height: .85;
    color: transparent;
    background: linear-gradient(
        120deg,
        #e0fbff 5%,
        #22d3ee 35%,
        #0891b2 65%,
        #f97316 100%
    );
    -webkit-background-clip: text;
    background-clip: text;
    filter: drop-shadow(0 0 25px rgba(34,211,238,.20));
    animation: numberGlow 3s ease-in-out infinite alternate;
}

@keyframes numberGlow {
    from { filter: drop-shadow(0 0 12px rgba(34,211,238,.15)); }
    to { filter: drop-shadow(0 0 32px rgba(34,211,238,.4)); }
}

/* Bike illustration */
.bike-wrap {
    width: min(100%, 390px);
    height: clamp(100px, 19vh, 150px);
    margin: 5px auto 0;
    position: relative;
}

.bike-wrap svg {
    width: 100%;
    height: 100%;
    overflow: visible;
    animation: bikeFloat 3s ease-in-out infinite;
}

@keyframes bikeFloat {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-7px); }
}

.wheel {
    transform-box: fill-box;
    transform-origin: center;
    animation: wheelSpin 2s linear infinite;
}

@keyframes wheelSpin {
    to { transform: rotate(360deg); }
}

.road {
    position: absolute;
    height: 2px;
    width: 80%;
    left: 10%;
    bottom: 9%;
    overflow: hidden;
    background: rgba(34,211,238,.13);
}

.road::after {
    content: "";
    position: absolute;
    height: 100%;
    width: 35%;
    background: linear-gradient(90deg, transparent, #22d3ee, transparent);
    animation: roadMove 1.5s linear infinite;
}

@keyframes roadMove {
    from { transform: translateX(-100%); }
    to { transform: translateX(300%); }
}

.eyebrow {
    color: #22d3ee;
    font-size: 11px;
    font-weight: 800;
    letter-spacing: 4px;
    text-transform: uppercase;
    margin-top: 5px;
    margin-bottom: 10px;
}

h1 {
    font-size: clamp(25px, 4vw, 39px);
    font-weight: 850;
    letter-spacing: -.8px;
    color: #fff;
}

.description {
    color: #9aadc2;
    max-width: 440px;
    margin: 12px auto 23px;
    font-size: clamp(12px, 1.5vw, 14px);
    line-height: 1.7;
}

.actions {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 13px;
    flex-wrap: wrap;
}

.btn {
    position: relative;
    min-width: 155px;
    min-height: 47px;
    padding: 0 22px;
    display: inline-flex;
    justify-content: center;
    align-items: center;
    gap: 9px;
    border-radius: 12px;
    font-size: 13px;
    font-weight: 800;
    text-decoration: none;
    transition: transform .25s, box-shadow .25s, border-color .25s;
}

.btn-home {
    color: #04131e;
    background: linear-gradient(110deg, #22d3ee, #67e8f9);
    box-shadow: 0 5px 24px rgba(34,211,238,.2);
}

.btn-home:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 32px rgba(34,211,238,.38);
}

.btn-back {
    color: #d8e8f6;
    border: 1px solid rgba(148,163,184,.28);
    background: rgba(255,255,255,.04);
    backdrop-filter: blur(12px);
}

.btn-back:hover {
    transform: translateY(-4px);
    border-color: #22d3ee;
    background: rgba(34,211,238,.08);
}

.footer {
    margin-top: clamp(18px, 4vh, 34px);
    color: #647b91;
    font-size: 11px;
    letter-spacing: .5px;
}

.footer span {
    color: #22d3ee;
}

/* Compact screens */
@media (max-height: 620px) {
    .content { transform: scale(.82); }
    .brand { margin-bottom: 5px; }
    .bike-wrap { height: 90px; }
    .description { margin: 8px auto 13px; }
    .footer { margin-top: 14px; }
}

@media (max-width: 480px) {
    .scene { padding: 12px; }
    .error-number { font-size: clamp(100px, 29vw, 135px); }
    .bike-wrap { width: 95%; }
    .description { max-width: 320px; }
    .btn { min-width: 135px; padding: 0 15px; }
}

@media (prefers-reduced-motion: reduce) {
    *, *::before, *::after {
        animation-duration: .01ms !important;
        animation-iteration-count: 1 !important;
        scroll-behavior: auto !important;
    }
}
</style>
</head>

<body>
<div class="scene">
    <div class="ambient"></div>
    <div class="grid-bg"></div>

    <div class="particles" aria-hidden="true">
        <i class="particle"></i>
        <i class="particle"></i>
        <i class="particle"></i>
        <i class="particle"></i>
        <i class="particle"></i>
        <i class="particle"></i>
    </div>

    <main class="content">

        <a class="brand" href="/Client/Home.aspx">
            <img src="/Uploads/EBikes-Duniya-Logo.png"
                 alt="EBikes Duniya" />
        </a>

        <div class="error-number">404</div>

        <div class="bike-wrap">
            <svg viewBox="0 0 400 160" role="img" aria-label="Animated electric bike">
                <defs>
                    <linearGradient id="bikePaint" x1="0" x2="1">
                        <stop offset="0%" stop-color="#0891b2"/>
                        <stop offset="100%" stop-color="#22d3ee"/>
                    </linearGradient>
                    <filter id="bikeGlow">
                        <feGaussianBlur stdDeviation="3" result="blur"/>
                        <feMerge>
                            <feMergeNode in="blur"/>
                            <feMergeNode in="SourceGraphic"/>
                        </feMerge>
                    </filter>
                </defs>

                <g fill="none" stroke="#b8f5ff" stroke-width="4">
                    <circle cx="92" cy="118" r="29"/>
                    <circle cx="307" cy="118" r="29"/>
                </g>

                <g class="wheel" fill="none" stroke="#22d3ee" stroke-width="2">
                    <path d="M92 89 V147 M63 118 H121 M71 97 L113 139 M113 97 L71 139"/>
                    <path d="M307 89 V147 M278 118 H336 M286 97 L328 139 M328 97 L286 139"/>
                </g>

                <g filter="url(#bikeGlow)" fill="none" stroke="url(#bikePaint)"
                   stroke-width="7" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M92 118 L162 118 L220 72 L278 118 L307 118"/>
                    <path d="M162 118 L145 70 L194 70 L220 72"/>
                    <path d="M278 118 L260 57 L281 57"/>
                    <path d="M145 70 L129 70"/>
                </g>

                <path d="M188 64 Q215 48 239 65 L254 91 L203 91 Z"
                      fill="#0e7490" stroke="#22d3ee" stroke-width="3"/>
                <path d="M260 57 H284" stroke="#22d3ee" stroke-width="5" stroke-linecap="round"/>
                <path d="M275 50 H288" stroke="#f97316" stroke-width="4" stroke-linecap="round"/>
                <path d="M190 101 L207 101" stroke="#f97316" stroke-width="4" stroke-linecap="round"/>

                <path d="M236 34 L244 20 L252 34 L266 41 L252 48 L244 62 L236 48 L222 41 Z"
                      fill="#22d3ee" filter="url(#bikeGlow)"/>
            </svg>
            <div class="road"></div>
        </div>

        <p class="eyebrow">⚡ Wrong Turn, Rider!</p>

        <h1>Oops! Page Not Found</h1>

        <p class="description">
            Looks like you've taken a wrong turn!
            This page doesn't exist or may have been moved.
            Let's get you back on the electric highway.
        </p>

        <div class="actions">
            <a href="/Client/Home.aspx" class="btn btn-home">
                ⚡ Back to Home
            </a>

            <a href="javascript:history.back()" class="btn btn-back">
                ← Go Back
            </a>
        </div>

        <div class="footer">
            © 2026 <span>EBikes Duniya</span> · Ride Electric. Ride Smarter.
        </div>

    </main>
</div>
</body>
</html>
