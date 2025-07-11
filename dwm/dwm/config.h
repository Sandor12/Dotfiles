/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>
/* appearance */
static const unsigned int borderpx = 1; /* border pixel of windows */
static const unsigned int snap = 0;     /* snap pixel */
static const int showbar = 1;           /* 0 means no bar */
static const int topbar = 1;            /* 0 means bottom bar */
static const char *fonts[] = {"monospace:size=8"};
static const char dmenufont[] = "monospace:size=8";
static const char col_gray1[] = "#222222";
static const char col_gray2[] = "#444444";
static const char col_gray3[] = "#bbbbbb";
static const char col_gray4[] = "#eeeeee";
static const char col_cyan[] = "#005577";
static const char *colors[][3] = {
    /*               fg         bg         border   */
    [SchemeNorm] = {col_gray3, col_gray1, col_gray2},
    [SchemeSel] = {col_gray4,  col_cyan,  col_cyan},
};

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     isfloating   monitor */
    {"Firefox", NULL, NULL, 1 << 8, 0, -1},
};

/* layout(s) */
static const float mfact = 0.50;     /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;        /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

#include "fibonacci.c"
static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[\\]", dwindle}, /* */
    { "[]=",    tile}, /* first entry is default */
    { "><>",    NULL}, /* no layout function means floating behavior */
    { "[M]", monocle}, /* */
    { "[@]",  spiral}, /* */
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG) {MODKEY, KEY, view, {.ui = 1 << TAG}}, {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}}, {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}}, {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       \
    {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    \
        .v = (const char *[]) { "/usr/bin/alacritty", "--command", cmd, NULL }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           \
    }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {"dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL};
static const char *termcmd[] = {"alacritty", "--command", "tmux", NULL};
static const char *freetube[] = {"freetube", NULL};
static const char *firefox[] = {"firefox", NULL};
static const char *discord[] = {"discord", NULL};
static const char *flameshot[] = {"flameshot", "gui", NULL};
static const char *upvol[] = {"pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%", NULL};
static const char *downvol[] = {"pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%", NULL};
static const char *mutevol[] = {"pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle", NULL};
static const char *mutemic[] = {"pactl", "set-source-mute", "@DEFAULT_SOURCE@", "toggle", NULL};
static const char *downbrightness[] = {"brightness.sh", "-d", "25", NULL};
static const char *upbrightness[] = {"brightness.sh", "-u", "25", NULL};

static const Key keys[] = {
    /* modifier                     key        function        argument */
    {              MODKEY,                     XK_d,          spawn,       {.v = dmenucmd}},
    {              MODKEY,                XK_Return,          spawn,        {.v = termcmd}},
    {MODKEY | ControlMask,                     XK_w,          spawn,        {.v = firefox}},
    {MODKEY | ControlMask,                     XK_y,          spawn,       {.v = freetube}},
    {MODKEY | ControlMask,                     XK_d,          spawn,        {.v = discord}},
    {                   0,                 XK_Print,          spawn,      {.v = flameshot}},
    {                   0,         XF86XK_AudioMute,          spawn,        {.v = mutevol}},
    {                   0,  XF86XK_AudioLowerVolume,          spawn,        {.v = downvol}},
    {                   0,  XF86XK_AudioRaiseVolume,          spawn,          {.v = upvol}},
    {                   0,      XF86XK_AudioMicMute,          spawn,        {.v = mutemic}},
    {                   0, XF86XK_MonBrightnessDown,          spawn, {.v = downbrightness}},
    {                   0,   XF86XK_MonBrightnessUp,          spawn,   {.v = upbrightness}},
    {              MODKEY,                     XK_b,      togglebar,                   {0}},
    {              MODKEY,                     XK_j,     focusstack,             {.i = +1}},
    {              MODKEY,                     XK_k,     focusstack,             {.i = -1}},
    {              MODKEY,                     XK_i,     incnmaster,             {.i = +1}},
    {              MODKEY,                     XK_o,     incnmaster,             {.i = -1}},
    {              MODKEY,                     XK_h,       setmfact,          {.f = -0.05}},
    {              MODKEY,                     XK_l,       setmfact,          {.f = +0.05}},
    {  MODKEY | ShiftMask,                     XK_h,           zoom,                   {0}},
    {  MODKEY | ShiftMask,                     XK_l,           zoom,                   {0}},
    {              MODKEY,                   XK_Tab,           view,                   {0}},
    {  MODKEY | ShiftMask,                     XK_a,     killclient,                   {0}},
    {              MODKEY,                     XK_t,      setlayout,    {.v = &layouts[1]}},
    {              MODKEY,                     XK_f,      setlayout,    {.v = &layouts[2]}},
    {              MODKEY,                     XK_m,      setlayout,    {.v = &layouts[3]}},
    {              MODKEY,                     XK_r,      setlayout,    {.v = &layouts[0]}},
    {              MODKEY,                 XK_space,      setlayout,                   {0}},
    {  MODKEY | ShiftMask,                 XK_space, togglefloating,                   {0}},
    {              MODKEY,                     XK_0,           view,            {.ui = ~0}},
    {  MODKEY | ShiftMask,                     XK_0,            tag,            {.ui = ~0}},
    {              MODKEY,                 XK_comma,       focusmon,             {.i = -1}},
    {              MODKEY,                XK_period,       focusmon,             {.i = +1}},
    {  MODKEY | ShiftMask,                 XK_comma,         tagmon,             {.i = -1}},
    {  MODKEY | ShiftMask,                XK_period,         tagmon,             {.i = +1}},
    TAGKEYS(0x26, 0) TAGKEYS(0xe9, 1) TAGKEYS(0x22, 2) TAGKEYS(0x27, 3) TAGKEYS(0x28, 4) TAGKEYS(0x2d, 5) TAGKEYS(0xe8, 6) TAGKEYS(0x5f, 7) TAGKEYS(0xe7, 8){  MODKEY | ShiftMask,                     XK_q,           quit,                   {0}},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask      button          function argument */
    {  ClkLtSymbol,      0, Button1,      setlayout,                {0}},
    {  ClkLtSymbol,      0, Button3,      setlayout, {.v = &layouts[2]}},
    {  ClkWinTitle,      0, Button2,           zoom,                {0}},
    {ClkStatusText,      0, Button2,          spawn,     {.v = termcmd}},
    { ClkClientWin, MODKEY, Button1,      movemouse,                {0}},
    { ClkClientWin, MODKEY, Button2, togglefloating,                {0}},
    { ClkClientWin, MODKEY, Button3,    resizemouse,                {0}},
    {    ClkTagBar,      0, Button1,           view,                {0}},
    {    ClkTagBar,      0, Button3,     toggleview,                {0}},
    {    ClkTagBar, MODKEY, Button1,            tag,                {0}},
    {    ClkTagBar, MODKEY, Button3,      toggletag,                {0}},
};

static const char *const autostart[] = {"wal", "-i", "/home/sandor/.background.jpg", NULL, "sh", "-c", "exec $HOME/.stat.sh", NULL, "flameshot", NULL, NULL};
