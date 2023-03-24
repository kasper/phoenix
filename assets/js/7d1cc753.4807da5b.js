"use strict";(self.webpackChunk_phoenix_docs=self.webpackChunk_phoenix_docs||[]).push([[402],{3905:(e,n,t)=>{t.d(n,{Zo:()=>p,kt:()=>w});var i=t(7294);function r(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function o(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);n&&(i=i.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,i)}return t}function a(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?o(Object(t),!0).forEach((function(n){r(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):o(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function l(e,n){if(null==e)return{};var t,i,r=function(e,n){if(null==e)return{};var t,i,r={},o=Object.keys(e);for(i=0;i<o.length;i++)t=o[i],n.indexOf(t)>=0||(r[t]=e[t]);return r}(e,n);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(i=0;i<o.length;i++)t=o[i],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(r[t]=e[t])}return r}var s=i.createContext({}),d=function(e){var n=i.useContext(s),t=n;return e&&(t="function"==typeof e?e(n):a(a({},n),e)),t},p=function(e){var n=d(e.components);return i.createElement(s.Provider,{value:n},e.children)},u="mdxType",c={inlineCode:"code",wrapper:function(e){var n=e.children;return i.createElement(i.Fragment,{},n)}},m=i.forwardRef((function(e,n){var t=e.components,r=e.mdxType,o=e.originalType,s=e.parentName,p=l(e,["components","mdxType","originalType","parentName"]),u=d(t),m=r,w=u["".concat(s,".").concat(m)]||u[m]||c[m]||o;return t?i.createElement(w,a(a({ref:n},p),{},{components:t})):i.createElement(w,a({ref:n},p))}));function w(e,n){var t=arguments,r=n&&n.mdxType;if("string"==typeof e||r){var o=t.length,a=new Array(o);a[0]=m;var l={};for(var s in n)hasOwnProperty.call(n,s)&&(l[s]=n[s]);l.originalType=e,l[u]="string"==typeof e?e:r,a[1]=l;for(var d=2;d<o;d++)a[d]=t[d];return i.createElement.apply(null,a)}return i.createElement.apply(null,t)}m.displayName="MDXCreateElement"},5166:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>s,contentTitle:()=>a,default:()=>c,frontMatter:()=>o,metadata:()=>l,toc:()=>d});var i=t(7462),r=(t(7294),t(3905));const o={},a="Window",l={unversionedId:"api/window",id:"api/window",title:"Window",description:"Use Window to control app windows. Every screen (i.e. display) combines to form a large rectangle. Every window lives within this rectangle and their position can be altered by giving coordinates inside this rectangle. To position a window to a specific display, you need to calculate its position within the large rectangle. To figure out the coordinates for a given screen, use the functions in Screen. Beware that a window can get stale if you keep a reference to it and it is for instance closed while you do so.",source:"@site/docs/api/window.md",sourceDirName:"api",slug:"/api/window",permalink:"/phoenix/api/window",draft:!1,editUrl:"https://github.com/kasper/phoenix/tree/master/docs/docs/api/window.md",tags:[],version:"current",frontMatter:{},sidebar:"sidebar",previous:{title:"Timer",permalink:"/phoenix/api/timer"}},s={},d=[{value:"Interface",id:"interface",level:2},{value:"Static Methods",id:"static-methods",level:2},{value:"Window Optionals",id:"window-optionals",level:3},{value:"Instance Methods",id:"instance-methods",level:2},{value:"Others Optionals",id:"others-optionals",level:3},{value:"Events",id:"events",level:2},{value:"Example",id:"example",level:2}],p={toc:d},u="wrapper";function c(e){let{components:n,...t}=e;return(0,r.kt)(u,(0,i.Z)({},p,t,{components:n,mdxType:"MDXLayout"}),(0,r.kt)("h1",{id:"window"},"Window"),(0,r.kt)("p",null,"Use Window to control app windows. Every screen (i.e. display) combines to form a large rectangle. Every window lives within this rectangle and their position can be altered by giving coordinates inside this rectangle. To position a window to a specific display, you need to calculate its position within the large rectangle. To figure out the coordinates for a given screen, use the functions in ",(0,r.kt)("inlineCode",{parentName:"p"},"Screen"),". Beware that a window can get stale if you keep a reference to it and it is for instance closed while you do so."),(0,r.kt)("h2",{id:"interface"},"Interface"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-javascript"},"class Window implements Identifiable\n\n  static Window focused()\n  static Window at(Point point)\n  static Array<Window> all(Map<String, AnyObject> optionals)\n  static Array<Window> recent()\n\n  Array<Window> others(Map<String, AnyObject> optionals)\n  String title()\n  boolean isMain()\n  boolean isNormal()\n  boolean isFullScreen()\n  boolean isMinimised() // or isMinimized()\n  boolean isVisible()\n  App app()\n  Screen screen()\n  Array<Space> spaces() // macOS 10.11+\n  Point topLeft()\n  Size size()\n  Rectangle frame()\n  boolean setTopLeft(Point point)\n  boolean setSize(Size size)\n  boolean setFrame(Rectangle frame)\n  boolean setFullScreen(boolean value)\n  boolean maximise() // or maximize()\n  boolean minimise() // or minimize()\n  boolean unminimise() // or unminimize()\n  Array<Window> neighbours(String direction) // or neighbors(...)\n  boolean raise()\n  boolean focus()\n  boolean focusClosestNeighbour(String direction) // or focusClosestNeighbor(...)\n  boolean close()\n\nend\n")),(0,r.kt)("h2",{id:"static-methods"},"Static Methods"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"focused()")," returns the focused window for the currently active app, can be ",(0,r.kt)("inlineCode",{parentName:"li"},"undefined")," if no window is focused currently"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"at(Point point)")," returns the topmost window at the specified point, can be ",(0,r.kt)("inlineCode",{parentName:"li"},"undefined")," if no window is present at the given position"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"all(Map<String, AnyObject> optionals)")," returns all windows in screens if no optionals are given"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"recent()")," returns all visible windows in the order as they appear on the screen (from front to back), essentially returning them in the most-recently-used order")),(0,r.kt)("h3",{id:"window-optionals"},"Window Optionals"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"visible")," (boolean): if set ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," returns all visible windows in screens, if set ",(0,r.kt)("inlineCode",{parentName:"li"},"false")," returns all hidden windows in screens")),(0,r.kt)("h2",{id:"instance-methods"},"Instance Methods"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"others(Map<String, AnyObject> optionals)")," returns all other windows on all screens if no optionals are given"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"title()")," returns the title for the window"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"isMain()")," returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if the window is the main window for its app"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"isNormal()")," returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if the window is a normal window"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"isFullScreen()")," returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if the window is a full screen window"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"isMinimised()")," or ",(0,r.kt)("inlineCode",{parentName:"li"},"isMinimized()")," returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if the window is minimised"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"isVisible()")," returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if the window is a normal and unminimised window that belongs to an unhidden app"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"app()")," returns the app for the window"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"screen()")," returns the screen where most or all of the window is currently present, can be ",(0,r.kt)("inlineCode",{parentName:"li"},"undefined")," if a window is out of bounds of any screen"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"spaces()")," returns the spaces where the window is currently present (macOS 10.11+, returns an empty list otherwise)"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"topLeft()")," returns the top left point for the window"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"size()")," returns the size for the window"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"frame()")," returns the frame for the window"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"setTopLeft(Point point)")," sets the top left point for the window, returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"setSize(Size size)")," sets the size for the window, returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"setFrame(Rectangle frame)")," sets the frame for the window, returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"setFullScreen(boolean value)")," sets whether the window is full screen, returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"maximise()")," or ",(0,r.kt)("inlineCode",{parentName:"li"},"maximize()")," resizes the window to fit the whole visible frame for the screen, returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"minimise()")," or ",(0,r.kt)("inlineCode",{parentName:"li"},"minimize()")," minimises the window, returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"unminimise()")," or ",(0,r.kt)("inlineCode",{parentName:"li"},"unminimize()")," unminimises the window, returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"neighbours(String direction)")," or ",(0,r.kt)("inlineCode",{parentName:"li"},"neighbors(...)")," returns windows to the direction (",(0,r.kt)("inlineCode",{parentName:"li"},"west|east|north|south"),") of the window"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"raise()")," makes the window the frontmost window of its app (but does not focus the app itself), returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"focus()")," focuses the window, returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"focusClosestNeighbour(String direction)")," or ",(0,r.kt)("inlineCode",{parentName:"li"},"focusClosestNeighbor(...)")," focuses the closest window to the direction (",(0,r.kt)("inlineCode",{parentName:"li"},"west|east|north|south"),") of the window, returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"close()")," closes the window, returns ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," if successful")),(0,r.kt)("h3",{id:"others-optionals"},"Others Optionals"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"visible")," (boolean): if set ",(0,r.kt)("inlineCode",{parentName:"li"},"true")," returns visible windows, if set ",(0,r.kt)("inlineCode",{parentName:"li"},"false")," returns hidden windows"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"screen")," (Screen): returns all other windows on the specified screen")),(0,r.kt)("h2",{id:"events"},"Events"),(0,r.kt)("p",null,"See ",(0,r.kt)("a",{parentName:"p",href:"events#window"},"Events")," for a list of available events for Window."),(0,r.kt)("h2",{id:"example"},"Example"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-javascript"},"// Return all windows across all screens\nconst windows = Window.all();\n\n// Move the focused window to origo\nWindow.focused().setTopLeft({ x: 0, y: 0 });\n\n// Resize the focused window\nWindow.focused().setSize({ width: 1000, height: 500 });\n\n// Resize the focused window to fill the full screen\nWindow.focused().maximise();\n")))}c.isMDXComponent=!0}}]);