"use strict";(self.webpackChunk_phoenix_docs=self.webpackChunk_phoenix_docs||[]).push([[168],{3168:(e,n,s)=>{s.r(n),s.d(n,{assets:()=>l,contentTitle:()=>c,default:()=>h,frontMatter:()=>t,metadata:()=>a,toc:()=>o});var r=s(4848),i=s(8453);const t={},c="Screen",a={id:"api/screen",title:"Screen",description:"Use Screen to access frame sizes and other screens on a multi-screen setup. Beware that a screen can get stale if you keep a reference to it and it is for instance disconnected while you do so.",source:"@site/docs/api/screen.md",sourceDirName:"api",slug:"/api/screen",permalink:"/phoenix/api/screen",draft:!1,unlisted:!1,editUrl:"https://github.com/kasper/phoenix/tree/master/docs/docs/api/screen.md",tags:[],version:"current",frontMatter:{},sidebar:"sidebar",previous:{title:"Require",permalink:"/phoenix/api/require"},next:{title:"Size",permalink:"/phoenix/api/size"}},l={},o=[{value:"Interface",id:"interface",level:2},{value:"Static Methods",id:"static-methods",level:2},{value:"Instance Methods",id:"instance-methods",level:2},{value:"Optionals",id:"optionals",level:3},{value:"Events",id:"events",level:2},{value:"Example",id:"example",level:2}];function d(e){const n={a:"a",code:"code",h1:"h1",h2:"h2",h3:"h3",li:"li",p:"p",pre:"pre",ul:"ul",...(0,i.R)(),...e.components};return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(n.h1,{id:"screen",children:"Screen"}),"\n",(0,r.jsx)(n.p,{children:"Use Screen to access frame sizes and other screens on a multi-screen setup. Beware that a screen can get stale if you keep a reference to it and it is for instance disconnected while you do so."}),"\n",(0,r.jsx)(n.h2,{id:"interface",children:"Interface"}),"\n",(0,r.jsx)(n.pre,{children:(0,r.jsx)(n.code,{className:"language-javascript",children:"class Screen implements Identifiable, Iterable\n\n  static Screen main()\n  static Array<Screen> all()\n\n  String identifier()\n  Rectangle frame()\n  Rectangle visibleFrame()\n  Rectangle flippedFrame()\n  Rectangle flippedVisibleFrame()\n  Space currentSpace() // macOS 10.11+\n  Array<Space> spaces() // macOS 10.11+\n  Array<Window> windows(Map<String, AnyObject> optionals)\n\nend\n"})}),"\n",(0,r.jsx)(n.h2,{id:"static-methods",children:"Static Methods"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.code,{children:"main()"})," returns the screen containing the window with the keyboard focus"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.code,{children:"all()"})," returns all screens, the first screen in this array corresponds to the primary screen for the system"]}),"\n"]}),"\n",(0,r.jsx)(n.h2,{id:"instance-methods",children:"Instance Methods"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.code,{children:"identifier()"})," returns the UUID for the screen"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.code,{children:"frame()"})," returns the whole frame for the screen, bottom left based origin"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.code,{children:"visibleFrame()"})," returns the visible frame for the screen subtracting the Dock and Menu from the frame when visible, bottom left based origin"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.code,{children:"flippedFrame()"})," returns the whole frame for the screen, top left based origin"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.code,{children:"flippedVisibleFrame()"})," returns the visible frame for the screen subtracting the Dock and Menu from the frame when visible, top left based origin"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.code,{children:"currentSpace()"})," returns the current space for the screen (macOS 10.11+, returns ",(0,r.jsx)(n.code,{children:"undefined"})," otherwise)"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.code,{children:"spaces()"})," returns all spaces for the screen (macOS 10.11+, returns an empty list otherwise)"]}),"\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.code,{children:"windows(Map<String, AnyObject> optionals)"})," returns all windows for the screen if no optionals are given"]}),"\n"]}),"\n",(0,r.jsx)(n.h3,{id:"optionals",children:"Optionals"}),"\n",(0,r.jsxs)(n.ul,{children:["\n",(0,r.jsxs)(n.li,{children:[(0,r.jsx)(n.code,{children:"visible"})," (boolean): if set ",(0,r.jsx)(n.code,{children:"true"})," returns all visible windows for the screen, if set ",(0,r.jsx)(n.code,{children:"false"})," returns all hidden windows for the screen"]}),"\n"]}),"\n",(0,r.jsx)(n.h2,{id:"events",children:"Events"}),"\n",(0,r.jsxs)(n.p,{children:["See ",(0,r.jsx)(n.a,{href:"events#screen",children:"Events"})," for a list of available events for Screen."]}),"\n",(0,r.jsx)(n.h2,{id:"example",children:"Example"}),"\n",(0,r.jsx)(n.pre,{children:(0,r.jsx)(n.code,{className:"language-javascript",children:"// Get all available screens\nconst screens = Screen.all();\n\n// Get visible frame for the main screen\nconst frame = Screen.main().visibleFrame();\n\n// Get all windows on the main screen\nScreen.main().windows();\n\n// Get all visible windows on the main screen\nScreen.main().windows({ visible: true });\n"})})]})}function h(e={}){const{wrapper:n}={...(0,i.R)(),...e.components};return n?(0,r.jsx)(n,{...e,children:(0,r.jsx)(d,{...e})}):d(e)}},8453:(e,n,s)=>{s.d(n,{R:()=>c,x:()=>a});var r=s(6540);const i={},t=r.createContext(i);function c(e){const n=r.useContext(t);return r.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function a(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(i):e.components||i:c(e.components),r.createElement(t.Provider,{value:n},e.children)}}}]);