#!/usr/bin/python3
"""Build the English discussion-first numeric-planning research talk with LibreOffice UNO."""

from __future__ import annotations

import os
import subprocess
import sys
import time
from pathlib import Path

import uno
from com.sun.star.awt import Point, Size
from com.sun.star.beans import PropertyValue


ROOT = Path(__file__).resolve().parents[2]
DOCS = ROOT / "docs" / "12_연구_방향"
FIG = DOCS / "figures" / "발표_초안"
OUTPUT = DOCS / "04_지연된_수치_충돌과_선택적_휴리스틱_연구발표_초안.pptx"
PDF_OUTPUT = DOCS / "04_지연된_수치_충돌과_선택적_휴리스틱_연구발표_초안.pdf"

W, H = 33867, 19050
FONT = "Liberation Sans"

BG = 0xF7F8FC
WHITE = 0xFFFFFF
NAVY = 0x18324A
INK = 0x243447
MUTED = 0x64748B
LIGHT = 0xE8EDF3
TEAL = 0x0F9D92
TEAL_LIGHT = 0xDDF3F0
ORANGE = 0xF28E2B
ORANGE_LIGHT = 0xFFF0DE
RED = 0xD9534F
RED_LIGHT = 0xFBE6E4
BLUE = 0x4E79A7
BLUE_LIGHT = 0xE5EDF6
GREEN = 0x3B8F67
GREEN_LIGHT = 0xE2F1E9


def prop(name, value):
    p = PropertyValue()
    p.Name = name
    p.Value = value
    return p


def connect():
    local_ctx = uno.getComponentContext()
    resolver = local_ctx.ServiceManager.createInstanceWithContext(
        "com.sun.star.bridge.UnoUrlResolver", local_ctx
    )
    for _ in range(40):
        try:
            ctx = resolver.resolve(
                "uno:socket,host=localhost,port=2002;urp;StarOffice.ComponentContext"
            )
            return ctx
        except Exception:
            time.sleep(.25)
    raise RuntimeError("Could not connect to LibreOffice")


def add_shape(doc, page, service, x, y, w, h):
    shape = doc.createInstance(service)
    shape.Position = Point(int(x), int(y))
    shape.Size = Size(int(w), int(h))
    page.add(shape)
    return shape


def rect(doc, page, x, y, w, h, fill, line=None, radius=False):
    shape = add_shape(doc, page, "com.sun.star.drawing.RectangleShape", x, y, w, h)
    shape.FillColor = fill
    shape.LineColor = fill if line is None else line
    shape.LineWidth = 0 if line is None else 25
    return shape


def text(doc, page, x, y, w, h, value, size=18, color=INK, bold=False,
         align=0, valign=0, margin=80, italic=False):
    shape = add_shape(doc, page, "com.sun.star.drawing.TextShape", x, y, w, h)
    shape.String = value
    shape.FillStyle = 0
    shape.LineStyle = 0
    shape.CharFontName = FONT
    shape.CharHeight = float(size)
    shape.CharColor = color
    shape.CharWeight = 150.0 if bold else 100.0
    shape.CharPosture = 2 if italic else 0
    shape.ParaAdjust = align
    shape.TextLeftDistance = margin
    shape.TextRightDistance = margin
    shape.TextUpperDistance = margin
    shape.TextLowerDistance = margin
    try:
        shape.TextVerticalAdjust = valign
    except Exception:
        pass
    return shape


def line(doc, page, x, y, w, h, color=LIGHT, width=30):
    shape = add_shape(doc, page, "com.sun.star.drawing.LineShape", x, y, w, h)
    shape.LineColor = color
    shape.LineWidth = width
    return shape


def image(doc, page, path, x, y, w, h):
    shape = add_shape(doc, page, "com.sun.star.drawing.GraphicObjectShape", x, y, w, h)
    shape.GraphicURL = uno.systemPathToFileUrl(str(path.resolve()))
    return shape


def circle(doc, page, x, y, d, fill, label, size=17, color=WHITE):
    shape = add_shape(doc, page, "com.sun.star.drawing.EllipseShape", x, y, d, d)
    shape.FillColor = fill
    shape.LineColor = fill
    text(doc, page, x, y + d*.12, d, d*.65, label, size, color, True, 3, 2, 20)
    return shape


def new_slide(doc, title, number, kicker=None, source=None, dark=False):
    pages = doc.getDrawPages()
    if number == 1:
        page = pages.getByIndex(0)
    else:
        pages.insertNewByIndex(pages.getCount())
        page = pages.getByIndex(pages.getCount() - 1)
    page.Width, page.Height = W, H
    rect(doc, page, 0, 0, W, H, NAVY if dark else BG)
    if number > 1 and not dark:
        rect(doc, page, 0, 0, 450, H, TEAL)
        if kicker:
            text(doc, page, 1200, 520, 9000, 500, kicker.upper(), 9, TEAL, True, 0, 0, 0)
        text(doc, page, 1120, 900, 30000, 1300, title, 27, NAVY, True, 0, 0, 0)
        line(doc, page, 1120, 2250, 30500, 0, LIGHT, 28)
    if number > 1:
        text(doc, page, 30450, 18150, 1500, 350, f"{number:02d}", 8,
             0xC8D5E1 if dark else MUTED, True, 3, 0, 0)
    if source:
        text(doc, page, 1150, 18050, 28500, 420, source, 7.5,
             0xBBC9D5 if dark else MUTED, False, 0, 0, 0)
    return page


def card(doc, page, x, y, w, h, title_, body, accent=TEAL, fill=WHITE,
         title_size=17, body_size=13.5):
    rect(doc, page, x, y, w, h, fill, LIGHT)
    rect(doc, page, x, y, 115, h, accent)
    text(doc, page, x+350, y+250, w-650, 650, title_, title_size, NAVY, True, 0, 0, 0)
    text(doc, page, x+350, y+1050, w-650, h-1250, body, body_size, INK, False, 0, 0, 0)


def badge(doc, page, x, y, w, label, fill=TEAL_LIGHT, color=TEAL):
    rect(doc, page, x, y, w, 600, fill, fill)
    text(doc, page, x, y+65, w, 420, label, 10.5, color, True, 3, 2, 10)


def bullet_list(doc, page, x, y, w, items, size=16, gap=920, color=INK):
    for i, item in enumerate(items):
        yy = y + i*gap
        circle(doc, page, x, yy+115, 260, TEAL, "", 1)
        text(doc, page, x+450, yy, w-450, gap-80, item, size, color, False, 0, 0, 0)


# One discussion point per slide, with supporting evidence and no prose analysis.
SLIDES = [
    ("RESEARCH DISCUSSION", "Anticipating\nnumeric conflicts", "Fast planning under resource constraints", "", "title"),
    ("MOTIVATION", "Robots need useful plans.\nQuickly.", "Planning time is part of the task.", "", "statement"),
    ("THE TRADE-OFF", "Fast guidance can miss\nresource interactions.", "More reasoning also costs time.", "[1] Hoffmann, 2003 · [2] Coles et al., 2008", "statement"),
    ("PROBLEM STRUCTURE", "A domain name\nis not a difficulty model.", "Resources, goals and routes interact within each problem.", "Discussion informed by our benchmark and resource-control experiments", "statement"),
    ("CONSTRAINTS", "Tighter constraints\ncan help search.", "Some choices become impossible sooner.", "Discussion informed by our Logistics experiments", "statement"),
    ("DELAYED CONFLICT", "A feasible action can lead\nto an infeasible future.", "Local applicability does not guarantee a feasible continuation.", "Discussion informed by our Barman stock experiments", "chain"),
    ("WORKING HYPOTHESIS", "Misleading choices\ncan survive too long.", "Late conflict detection may leave more unproductive search.", "Hypothesis motivated by synthetic and domain-schema micro experiments", "statement"),
    ("HEURISTIC DEPENDENCE", "An extra branch matters\nonly if search follows it.", "Structure and search guidance must be considered together.", "Discussion informed by our Watering and Logistics micro experiments", "statement"),
    ("RESEARCH PROBLEM", "Bring future resource conflicts\ninto current search guidance.", "The signal must be useful enough—and cheap enough.", "", "focus"),
    ("EXISTING NUMERIC REASONING", "Richer numeric reasoning\nalready exists.", "The question is when its extra computation pays off.", "[2] LP–RPG · [3] Subgoaling · [4] Intervals · [5] LM-cut · [6] CEGAR", "statement"),
    ("RELATED WORK", "Selective evaluation\nalready has a foundation.", "Our candidate signal: where numeric relaxation may mislead.", "[7] Selective Max · [8] Dynamic heuristic selection · [9] Numeric multi-queue search", "statement"),
    ("METHOD CANDIDATE · NOT FIXED", "Use a cheap signal to allocate\nadditional reasoning.", "Conflict signal  →  Selective evaluation  →  Search guidance", "Potential-based signals and semantic priors remain candidate designs.", "focus"),
    ("NEXT QUESTION", "Where does additional\nreasoning actually help?", "Compare heuristic decisions on the same states.", "Next step: state-level solvability, heuristic values and evaluation cost", "statement"),
    ("DISCUSSION", "Can we predict misleading\nguidance before the conflict?", "Can that prediction save more time than it costs?", "", "focus"),
]

REFERENCES = [
    ("Numeric reasoning", [
        ("[1] J. Hoffmann (2003)", "The Metric-FF Planning System: Translating ‘Ignoring Delete Lists’ to Numeric State Variables. JAIR 20, 291–341.", "https://arxiv.org/abs/1106.5271"),
        ("[2] A. I. Coles, M. Fox, D. Long & A. Smith (2008)", "A Hybrid Relaxed Planning Graph–LP Heuristic for Numeric Planning Domains. ICAPS.", "https://nms.kcl.ac.uk/andrew.coles/publications/publication2267.pdf"),
        ("[3] E. Scala, P. Haslum & S. Thiébaux (2016)", "Heuristics for Numeric Planning via Subgoaling. IJCAI, 3228–3234.", "https://www.ijcai.org/Proceedings/16/Papers/457.pdf"),
    ]),
    ("Numeric reasoning", [
        ("[4] E. Scala, P. Haslum, S. Thiébaux & M. Ramírez (2016)", "Interval-Based Relaxation for General Numeric Planning. ECAI.", "https://users.cecs.anu.edu.au/~thiebaux/papers/ecai16.pdf"),
        ("[5] R. Kuroiwa, A. Shleyfman, C. Piacentini, M. P. Castro & J. C. Beck (2021)", "LM-cut and Operator Counting Heuristics for Optimal Numeric Planning with Simple Conditions. ICAPS 31, 210–218.", "https://ojs.aaai.org/index.php/ICAPS/article/view/15964"),
        ("[6] T. Schindler, D. Speck & M. Helmert (2026)", "Cartesian Abstraction Refinement for Simple Numeric Planning. ICAPS 36, 420–424.", "https://ai.dmi.unibas.ch/papers/schindler-et-al-icaps2026.pdf"),
    ]),
    ("Heuristic selection and combination", [
        ("[7] C. Domshlak, E. Karpas & S. Markovitch (2010)", "To Max or Not to Max: Online Learning for Speeding Up Optimal Planning. AAAI.", "https://ojs.aaai.org/index.php/AAAI/article/view/7741"),
        ("[8] D. Speck, A. Biedenkapp, F. Hutter, R. Mattmüller & M. Lindauer (2021)", "Learning Heuristic Selection with Dynamic Algorithm Configuration. ICAPS.", "https://icaps21.icaps-conference.org/papers/exhibition_files/index_152.html"),
        ("[9] D. Z. Chen & S. Thiébaux (2024)", "Novelty Heuristics, Multi-Queue Search, and Portfolios for Numeric Planning. SoCS 17.", "https://arxiv.org/abs/2404.05235"),
    ]),
]


def canvas(doc, number, kicker, dark=False):
    pages=doc.getDrawPages()
    if number > 1:
        pages.insertNewByIndex(pages.getCount())
    page=pages.getByIndex(pages.getCount()-1)
    page.Width, page.Height=W,H
    rect(doc,page,0,0,W,H,NAVY if dark else BG)
    rect(doc,page,2000,1950,1300,140,TEAL)
    text(doc,page,2000,2550,29700,800,kicker,15,0x8ADBD2 if dark else TEAL,True,margin=0)
    text(doc,page,30700,17650,1100,500,f"{number:02d}",12,0xBBC9D5 if dark else MUTED,align=3,margin=0)
    return page


# Evidence supports each discussion point; numerical analysis is delivered orally.
TABLES = {
    3: (["Planner / heuristic", "Valid", "Total time (s)", "Objective gap*"], [
        ["Metric-FF / numeric-hff", "30/30", "8.6", "8.2%"],
        ["Panino / hadd-novelty", "30/30", "397.8", "35.0%"],
        ["Count Downward / irhff", "28/30", "626.8", "18.1%"],
        ["NFD / irhadd", "27/30", "1,407.7", "7.2%"],
        ["ENHSP / hadd", "25/30", "1,731.2", "5.8%"],
        ["ENHSP / hradd", "25/30", "1,596.1", "12.0%"],
    ], [12000,4600,6300,6900], "*Median excess over observed best, on solved tasks; solved sets differ. Total time includes timeouts."),
    4: (["Domain", "p000", "p001", "p002", "p003", "p004"], [
        ["Blocksworld", "97.7%", "95.3%", "88.4%", "83.7%", "81.4%"],
        ["Logistics", "95.3%", "62.8%", "32.6%", "18.6%", "16.3%"],
        ["Books", "93.3%", "75.6%", "44.4%", "17.8%", "15.6%"],
        ["Watering", "91.1%", "60.0%", "53.3%", "40.0%", "11.1%"],
        ["Barman", "78.4%", "32.4%", "8.1%", "10.8%", "8.1%"],
        ["Assembly", "93.3%", "73.3%", "66.7%", "51.1%", "22.2%"],
    ], [9000,4160,4160,4160,4160,4160], "VAL-valid rate across tested configurations; technical incompatibilities excluded."),
    5: (["Logistics / configuration", "L/L states", "T/T states"], [
        ["p003 · Count Downward / irhff", "737", "286"],
        ["p003 · ENHSP / hadd", "202", "45,992"],
        ["p003 · NFD / irhadd", "217", "32,946"],
        ["p004 · Count Downward / irhff", "131,514", "1,541"],
    ], [17200,6300,6300], "Expanded states. L/L: loose fuel + budget; T/T: tight fuel + budget. Same problem structure within each pair."),
    6: (["Barman p001", "Blocked-zero (s)", "One-short (s)"], [
        ["Metric-FF / numeric-hff", "0.20", "1.41"],
        ["Count Downward / irhff", "0.20", "2.61"],
        ["NFD / irhadd", "1.00", "32.32"],
        ["ENHSP / hadd", "0.40", "5.62"],
        ["ENHSP / hradd", "0.40", "5.62"],
    ], [14400,7700,7700], "Wall time to unsolved termination. Both variants unsolvable; deficit magnitude also differs."),
    8: (["Planner / heuristic", "Watering E/L", "E/H", "D/L", "D/H"], [
        ["Metric-FF / numeric-hff", "24", "44", "34", "64"],
        ["Count Downward / irhff", "5", "5", "12", "12"],
        ["NFD / irhadd", "18", "64", "49", "153"],
        ["ENHSP / hadd", "5", "5", "12", "12"],
        ["ENHSP / hradd", "5", "5", "12", "12"],
    ], [12400,6600,3600,3600,3600], "E/D: early/deep; L/H: low/high branching. Metric-FF: evaluated; others: expanded. Unsolvable micro tasks."),
}


def evidence_header(doc,page,title):
    text(doc,page,2000,3900,29800,3300,title,36,NAVY,True,margin=0)


def evidence_table(doc,page,headers,rows,widths,caption):
    y=7700
    rh=1000
    for ri,row in enumerate([headers]+rows):
        x=2000
        fill=NAVY if ri==0 else (WHITE if ri%2 else LIGHT)
        for ci,(value,width) in enumerate(zip(row,widths)):
            rect(doc,page,x,y+ri*rh,width,rh,fill)
            text(doc,page,x+180,y+ri*rh+220,width-360,720,value,21,
                 WHITE if ri==0 else INK,ri==0,align=0 if ci==0 else 3,margin=0)
            x+=width
    text(doc,page,2000,y+(len(rows)+1)*rh+400,29800,1050,caption,13,MUTED,margin=0)


def build(doc):
    for number,(kicker,title,body,source,kind) in enumerate(SLIDES,1):
        dark=kind in {"title","focus"}
        page=canvas(doc,number,kicker,dark)
        if number in TABLES:
            evidence_header(doc,page,title)
            evidence_table(doc,page,*TABLES[number])
        elif number==7:
            evidence_header(doc,page,title)
            image(doc,page,FIG/"07_synthetic_english.png",3600,7200,25700,8000)
            text(doc,page,2000,15450,29800,800,
                 "Synthetic pilot. False-finite labels use an external relaxation, not instrumented Metric-FF values.",13,MUTED,margin=0)
        else:
            text(doc,page,2000,5000,29800,5700,title,44,WHITE if dark else NAVY,True,margin=0)
            text(doc,page,2000,12000,29800,2400,body,27,0xBDD0DF if dark else MUTED,margin=0)
        if source:
            text(doc,page,2000,16700,28600,850,source,12,0xBDD0DF if dark else MUTED,margin=0)
        if kind=="title":
            text(doc,page,2000,16500,22000,850,"Changmin Park  /  Research discussion  /  September 2026",16,0xBDD0DF,margin=0)
    page=canvas(doc,len(SLIDES)+1,"REFERENCES")
    refs=[ref for _,group in REFERENCES for ref in group]
    for i,(author,title,url) in enumerate(refs):
        shape=text(doc,page,2000,4250+i*1330,29800,1280,author+". "+title,14,INK,margin=0)
        shape.ParaTopMargin=0
        shape.ParaBottomMargin=0
        spacing=uno.createUnoStruct("com.sun.star.style.LineSpacing")
        spacing.Mode=0
        spacing.Height=95
        shape.ParaLineSpacing=spacing

def main():
    profile = Path("/tmp/lo-numeric-research-ppt")
    profile.mkdir(parents=True, exist_ok=True)
    proc = subprocess.Popen([
        "/usr/bin/soffice", "--headless", "--nologo", "--nodefault", "--nofirststartwizard",
        f"-env:UserInstallation=file://{profile}",
        "--accept=socket,host=localhost,port=2002;urp;StarOffice.ServiceManager",
    ], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    try:
        ctx = connect()
        smgr = ctx.ServiceManager
        desktop = smgr.createInstanceWithContext("com.sun.star.frame.Desktop", ctx)
        doc = desktop.loadComponentFromURL("private:factory/simpress", "_blank", 0, ())
        build(doc)
        doc.storeAsURL(uno.systemPathToFileUrl(str(OUTPUT.resolve())), (
            prop("FilterName", "Impress MS PowerPoint 2007 XML"),
            prop("Overwrite", True),
        ))
        doc.storeToURL(uno.systemPathToFileUrl(str(PDF_OUTPUT.resolve())), (
            prop("FilterName", "impress_pdf_Export"),
            prop("Overwrite", True),
        ))
        doc.close(True)
        print(OUTPUT)
        print(PDF_OUTPUT)
    finally:
        proc.terminate()
        try:
            proc.wait(timeout=5)
        except subprocess.TimeoutExpired:
            proc.kill()


if __name__ == "__main__":
    main()
