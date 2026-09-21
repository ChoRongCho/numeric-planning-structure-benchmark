#!/usr/bin/env python3
"""Generate figures for the numeric-planning research presentation."""

from pathlib import Path
import csv

import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np


ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "docs" / "12_연구_방향" / "figures" / "발표_초안"
OUT.mkdir(parents=True, exist_ok=True)

FONT = "/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc"
mpl.font_manager.fontManager.addfont(FONT)
mpl.rcParams.update({
    "font.family": "Noto Sans CJK JP",
    "font.size": 12,
    "axes.unicode_minus": False,
    "axes.edgecolor": "#C9D1DC",
    "axes.labelcolor": "#334155",
    "xtick.color": "#475569",
    "ytick.color": "#475569",
    "figure.facecolor": "#F7F8FC",
    "axes.facecolor": "#F7F8FC",
})

NAVY = "#18324A"
TEAL = "#0F9D92"
ORANGE = "#F28E2B"
RED = "#D9534F"
BLUE = "#4E79A7"
GRAY = "#94A3B8"


def save(fig, name):
    fig.savefig(OUT / name, dpi=180, bbox_inches="tight", facecolor="#F7F8FC")
    plt.close(fig)


def coverage_quality():
    names = ["Metric-FF\nhFF", "Panino\nnovelty", "Count DW\nirhFF", "NFD\nirhadd", "ENHSP\nhadd", "ENHSP\nhradd"]
    coverage = [100, 100, 93.3, 90, 83.3, 83.3]
    quality = [8.2, 35.0, 18.1, 7.2, 5.8, 12.0]
    colors = [TEAL, GRAY, BLUE, ORANGE, RED, "#9C6ADE"]
    fig, axes = plt.subplots(1, 2, figsize=(12.4, 4.5), gridspec_kw={"wspace": .32})
    x = np.arange(len(names))
    axes[0].bar(x, coverage, color=colors, width=.68)
    axes[0].set_ylim(0, 110)
    axes[0].set_ylabel("VAL-valid coverage (%)")
    axes[0].set_xticks(x, names)
    axes[0].grid(axis="y", alpha=.2)
    for i, v in enumerate(coverage): axes[0].text(i, v + 2, f"{v:g}%", ha="center", fontsize=10, weight="bold")
    axes[1].bar(x, quality, color=colors, width=.68)
    axes[1].set_ylabel("관측 최저 대비 objective 중앙 초과율 (%)")
    axes[1].set_xticks(x, names)
    axes[1].grid(axis="y", alpha=.2)
    for i, v in enumerate(quality): axes[1].text(i, v + .8, f"{v:g}%", ha="center", fontsize=10, weight="bold")
    axes[0].spines[["top", "right"]].set_visible(False)
    axes[1].spines[["top", "right"]].set_visible(False)
    save(fig, "01_coverage_quality.png")


def difficulty_curves():
    data = {
        "Blocksworld": [97.7, 95.3, 88.4, 83.7, 81.4],
        "Logistics": [95.3, 62.8, 32.6, 18.6, 16.3],
        "Books": [93.3, 75.6, 44.4, 17.8, 15.6],
        "Watering": [91.1, 60.0, 53.3, 40.0, 11.1],
        "Barman": [78.4, 32.4, 8.1, 10.8, 8.1],
        "Assembly": [93.3, 73.3, 66.7, 51.1, 22.2],
    }
    colors = [GRAY, BLUE, "#59A14F", TEAL, RED, ORANGE]
    fig, ax = plt.subplots(figsize=(9.5, 5.2))
    x = np.arange(5)
    for (name, vals), color in zip(data.items(), colors):
        ax.plot(x, vals, marker="o", lw=2.5, ms=6, label=name, color=color)
    ax.set_xticks(x, ["p000", "p001", "p002", "p003", "p004"])
    ax.set_ylabel("전체 configuration의 VAL-valid 비율 (%)")
    ax.set_ylim(0, 105)
    ax.grid(alpha=.2)
    ax.legend(ncol=3, frameon=False, loc="lower left")
    ax.spines[["top", "right"]].set_visible(False)
    save(fig, "02_domain_problem_difficulty.png")


def quality_gap():
    labels = ["Logistics p003", "Logistics p004", "Watering p003", "Books p004"]
    fast = np.array([483, 774, 566, 425])
    best = np.array([144, 196, 184, 420])
    ratio = fast / best
    fig, ax = plt.subplots(figsize=(9.3, 4.2))
    y = np.arange(len(labels))
    ax.barh(y, ratio, color=[ORANGE, RED, TEAL, GRAY], height=.58)
    ax.axvline(1, color=NAVY, lw=1.5)
    ax.set_yticks(y, labels)
    ax.invert_yaxis()
    ax.set_xlabel("Metric-FF objective / 관측 최저 objective (낮을수록 좋음)")
    ax.set_xlim(0, 4.35)
    ax.grid(axis="x", alpha=.2)
    for i, (r, a, b) in enumerate(zip(ratio, fast, best)):
        ax.text(r + .07, i, f"{r:.2f}×  ({a}/{b})", va="center", fontsize=11, weight="bold")
    ax.spines[["top", "right", "left"]].set_visible(False)
    save(fig, "03_quality_gap.png")


def barman_delay():
    names = ["Metric-FF\nhFF", "Count DW\nirhFF", "NFD\nirhadd", "ENHSP\nhadd", "ENHSP\nhradd"]
    one = np.array([1.405, 2.61, 32.32, 5.62, 5.62])
    zero = np.array([.201, .201, 1.00, .402, .402])
    x = np.arange(len(names)); w=.34
    fig, ax = plt.subplots(figsize=(9.6, 4.7))
    ax.bar(x-w/2, zero, w, label="Blocked-zero: 즉시 모순", color=TEAL)
    ax.bar(x+w/2, one, w, label="One-short: 늦은 모순", color=RED)
    ax.set_yscale("log")
    ax.set_ylabel("Unsolvable 판정 wall time (초, log scale)")
    ax.set_xticks(x, names)
    ax.grid(axis="y", alpha=.2, which="both")
    ax.legend(frameon=False, ncol=2, loc="upper left")
    for i, (z, o) in enumerate(zip(zero, one)):
        ax.text(i+w/2, o*1.12, f"{o/z:.1f}×", ha="center", fontsize=10, weight="bold", color=RED)
    ax.spines[["top", "right"]].set_visible(False)
    save(fig, "04_barman_delayed_conflict.png")


def synthetic():
    variants = ["Early / Low", "Early / High", "Deep / Low", "Deep / High"]
    metric = [12,16,15,72]
    false = [1,2,4,30]
    x=np.arange(4); w=.36
    fig, ax = plt.subplots(figsize=(9.5,4.6))
    ax.bar(x-w/2, metric,w,label="Metric-FF evaluated states",color=BLUE)
    ax.bar(x+w/2,false,w,label="Oracle false-finite states",color=RED)
    ax.set_xticks(x,variants)
    ax.set_ylabel("상태 수")
    ax.grid(axis="y",alpha=.2)
    ax.legend(frameon=False,ncol=2,loc="upper left")
    for i,v in enumerate(metric): ax.text(i-w/2,v+1.5,str(v),ha="center",weight="bold")
    for i,v in enumerate(false): ax.text(i+w/2,v+1.5,str(v),ha="center",weight="bold")
    ax.spines[["top","right"]].set_visible(False)
    save(fig,"05_synthetic_2x2.png")


def micro_ratios():
    path = ROOT / "results" / "delayed-conflict" / "cross-domain-evidence" / "matched-micro-results.csv"
    rows=list(csv.DictReader(path.open()))
    labels=[
        ("metric-ff-cross-v1","numeric-hff","Metric-FF\nhFF"),
        ("count-downward-agile","irhff","Count DW\nirhFF"),
        ("numeric-fast-downward-local","irhadd","NFD\nirhadd"),
        ("enhsp","hadd","ENHSP\nhadd"),
        ("enhsp","hradd","ENHSP\nhradd"),
    ]
    ratios={}
    for domain in ("watering","logistics"):
        for planner,heuristic,label in labels:
            rr=[r for r in rows if r["domain"]==domain and r["planner"]==planner and r["heuristic"]==heuristic and r["branching"]=="low"]
            vals={r["depth"]:float(r["search_states"]) for r in rr}
            ratios[(domain,label)]=vals["deep"]/vals["early"]
    x=np.arange(len(labels)); w=.36
    fig,ax=plt.subplots(figsize=(9.6,4.6))
    names=[x[2] for x in labels]
    wa=[ratios[("watering",n)] for n in names]
    lo=[ratios[("logistics",n)] for n in names]
    ax.bar(x-w/2,wa,w,label="Watering",color=TEAL)
    ax.bar(x+w/2,lo,w,label="Logistics",color=ORANGE)
    ax.axhline(1,color=NAVY,lw=1.3)
    ax.set_xticks(x,names)
    ax.set_ylabel("Deep / Early 탐색 상태 비율")
    ax.set_ylim(0,3.45)
    ax.grid(axis="y",alpha=.2)
    ax.legend(frameon=False,ncol=2,loc="upper left")
    for i,v in enumerate(wa): ax.text(i-w/2,v+.07,f"{v:.2f}×",ha="center",fontsize=10,weight="bold")
    for i,v in enumerate(lo): ax.text(i+w/2,v+.07,f"{v:.2f}×",ha="center",fontsize=10,weight="bold")
    ax.spines[["top","right"]].set_visible(False)
    save(fig,"06_matched_micro_ratios.png")


if __name__ == "__main__":
    coverage_quality()
    difficulty_curves()
    quality_gap()
    barman_delay()
    synthetic()
    micro_ratios()
    print(OUT)
