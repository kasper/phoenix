"use strict";(self.webpackChunk_phoenix_docs=self.webpackChunk_phoenix_docs||[]).push([[384],{3905:(e,t,n)=>{n.d(t,{Zo:()=>p,kt:()=>w});var a=n(7294);function i(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function r(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){i(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function s(e,t){if(null==e)return{};var n,a,i=function(e,t){if(null==e)return{};var n,a,i={},o=Object.keys(e);for(a=0;a<o.length;a++)n=o[a],t.indexOf(n)>=0||(i[n]=e[n]);return i}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(a=0;a<o.length;a++)n=o[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(i[n]=e[n])}return i}var l=a.createContext({}),c=function(e){var t=a.useContext(l),n=t;return e&&(n="function"==typeof e?e(t):r(r({},t),e)),n},p=function(e){var t=c(e.components);return a.createElement(l.Provider,{value:t},e.children)},d="mdxType",u={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},m=a.forwardRef((function(e,t){var n=e.components,i=e.mdxType,o=e.originalType,l=e.parentName,p=s(e,["components","mdxType","originalType","parentName"]),d=c(n),m=i,w=d["".concat(l,".").concat(m)]||d[m]||u[m]||o;return n?a.createElement(w,r(r({ref:t},p),{},{components:n})):a.createElement(w,r({ref:t},p))}));function w(e,t){var n=arguments,i=t&&t.mdxType;if("string"==typeof e||i){var o=n.length,r=new Array(o);r[0]=m;var s={};for(var l in t)hasOwnProperty.call(t,l)&&(s[l]=t[l]);s.originalType=e,s[d]="string"==typeof e?e:i,r[1]=s;for(var c=2;c<o;c++)r[c]=n[c];return a.createElement.apply(null,r)}return a.createElement.apply(null,n)}m.displayName="MDXCreateElement"},3929:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>l,contentTitle:()=>r,default:()=>u,frontMatter:()=>o,metadata:()=>s,toc:()=>c});var a=n(7462),i=(n(7294),n(3905));const o={},r="Space",s={unversionedId:"api/space",id:"api/space",title:"Space",description:"Use the Space to control spaces. These features are only supported on El Capitan (10.11) and upwards. A single window can be in multiple spaces at the same time. To move a window to a different space, remove it from any existing spaces and add it to a new one. You can switch to a space by focusing on a window in that space. Beware that a space can get stale if you keep a reference to it and it is for instance closed while you do so.",source:"@site/docs/api/space.md",sourceDirName:"api",slug:"/api/space",permalink:"/phoenix/api/space",draft:!1,editUrl:"https://github.com/kasper/phoenix/tree/master/docs/docs/api/space.md",tags:[],version:"current",frontMatter:{},sidebar:"sidebar",previous:{title:"Size",permalink:"/phoenix/api/size"},next:{title:"Storage",permalink:"/phoenix/api/storage"}},l={},c=[{value:"Interface",id:"interface",level:2},{value:"Static Methods",id:"static-methods",level:2},{value:"Instance Methods",id:"instance-methods",level:2},{value:"3.0.0+",id:"300",level:3},{value:"Optionals",id:"optionals",level:3},{value:"Events",id:"events",level:2},{value:"Example",id:"example",level:2}],p={toc:c},d="wrapper";function u(e){let{components:t,...n}=e;return(0,i.kt)(d,(0,a.Z)({},p,n,{components:t,mdxType:"MDXLayout"}),(0,i.kt)("h1",{id:"space"},"Space"),(0,i.kt)("p",null,"Use the Space to control spaces. ",(0,i.kt)("em",{parentName:"p"},"These features are only supported on El Capitan (10.11) and upwards.")," A single window can be in multiple spaces at the same time. To move a window to a different space, remove it from any existing spaces and add it to a new one. You can switch to a space by focusing on a window in that space. Beware that a space can get stale if you keep a reference to it and it is for instance closed while you do so."),(0,i.kt)("h2",{id:"interface"},"Interface"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-javascript"},"class Space implements Identifiable, Iterable\n\n  static Space active() // macOS 10.11+\n  static Array<Space> all() // macOS 10.11+\n\n  boolean isNormal()\n  boolean isFullScreen()\n  Array<Screen> screens()\n  Array<Window> windows(Map<String, AnyObject> optionals)\n  void addWindows(Array<Window> windows)\n  void removeWindows(Array<Window> windows)\n  void moveWindows(Array<Window> windows)\n\nend\n")),(0,i.kt)("h2",{id:"static-methods"},"Static Methods"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"active()")," returns the space containing the window with the keyboard focus (macOS 10.11+, returns ",(0,i.kt)("inlineCode",{parentName:"li"},"undefined")," otherwise)"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"all()")," returns all spaces, the first space in this array corresponds to the primary space (macOS 10.11+, returns an empty list otherwise)")),(0,i.kt)("h2",{id:"instance-methods"},"Instance Methods"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"isNormal()")," returns ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," if the space is a normal space"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"isFullScreen()")," returns ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," if the space is a full screen space"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"screens()")," returns all screens to which the space belongs to"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"windows(Map<String, AnyObject> optionals)")," returns all windows for the space if no optionals are given"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"addWindows(Array<Window> windows)")," adds the given windows to the space (< macOS 12.0)"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"removeWindows(Array<Window> windows)")," removes the given windows from the space (< macOS 12.0)")),(0,i.kt)("h3",{id:"300"},"3.0.0+"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"moveWindows(Array<Window> windows)")," moves the given windows to the space (macOS 10.13+)")),(0,i.kt)("h3",{id:"optionals"},"Optionals"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"visible")," (boolean): if set ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," returns all visible windows for the space, if set ",(0,i.kt)("inlineCode",{parentName:"li"},"false")," returns all hidden windows for the space")),(0,i.kt)("h2",{id:"events"},"Events"),(0,i.kt)("p",null,"See ",(0,i.kt)("a",{parentName:"p",href:"events#space"},"Events")," for a list of available events for Space."),(0,i.kt)("h2",{id:"example"},"Example"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-javascript"},"// Move focused window to the next space and focus to the space (macOS 12.0+)\nconst space = Space.active();\nconst window = Window.focused();\nspace.moveWindows([window]);\nwindow.focus();\n\n// Move focused window to the next space and focus to the space (< macOS 12.0)\nconst space = Space.active();\nconst window = Window.focused();\nspace.next().addWindows([window]);\nspace.removeWindows([window]);\nwindow.focus();\n")))}u.isMDXComponent=!0}}]);