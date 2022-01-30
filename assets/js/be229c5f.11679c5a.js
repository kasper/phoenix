"use strict";(self.webpackChunk_phoenix_docs=self.webpackChunk_phoenix_docs||[]).push([[967],{3905:function(e,n,t){t.d(n,{Zo:function(){return p},kt:function(){return m}});var a=t(7294);function r(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function i(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);n&&(a=a.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,a)}return t}function o(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?i(Object(t),!0).forEach((function(n){r(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):i(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function s(e,n){if(null==e)return{};var t,a,r=function(e,n){if(null==e)return{};var t,a,r={},i=Object.keys(e);for(a=0;a<i.length;a++)t=i[a],n.indexOf(t)>=0||(r[t]=e[t]);return r}(e,n);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(a=0;a<i.length;a++)t=i[a],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(r[t]=e[t])}return r}var l=a.createContext({}),c=function(e){var n=a.useContext(l),t=n;return e&&(t="function"==typeof e?e(n):o(o({},n),e)),t},p=function(e){var n=c(e.components);return a.createElement(l.Provider,{value:n},e.children)},d={inlineCode:"code",wrapper:function(e){var n=e.children;return a.createElement(a.Fragment,{},n)}},u=a.forwardRef((function(e,n){var t=e.components,r=e.mdxType,i=e.originalType,l=e.parentName,p=s(e,["components","mdxType","originalType","parentName"]),u=c(t),m=r,f=u["".concat(l,".").concat(m)]||u[m]||d[m]||i;return t?a.createElement(f,o(o({ref:n},p),{},{components:t})):a.createElement(f,o({ref:n},p))}));function m(e,n){var t=arguments,r=n&&n.mdxType;if("string"==typeof e||r){var i=t.length,o=new Array(i);o[0]=u;var s={};for(var l in n)hasOwnProperty.call(n,l)&&(s[l]=n[l]);s.originalType=e,s.mdxType="string"==typeof e?e:r,o[1]=s;for(var c=2;c<i;c++)o[c]=t[c];return a.createElement.apply(null,o)}return a.createElement.apply(null,t)}u.displayName="MDXCreateElement"},9069:function(e,n,t){t.r(n),t.d(n,{frontMatter:function(){return s},contentTitle:function(){return l},metadata:function(){return c},toc:function(){return p},default:function(){return u}});var a=t(7462),r=t(3366),i=(t(7294),t(3905)),o=["components"],s={},l="Space",c={unversionedId:"api/space",id:"api/space",title:"Space",description:"Use the Space to control spaces. These features are only supported on El Capitan (10.11) and upwards. A single window can be in multiple spaces at the same time. To move a window to a different space, remove it from any existing spaces and add it to a new one. You can switch to a space by focusing on a window in that space. Beware that a space can get stale if you keep a reference to it and it is for instance closed while you do so.",source:"@site/docs/api/19-space.md",sourceDirName:"api",slug:"/api/space",permalink:"/phoenix/api/space",editUrl:"https://github.com/kasper/phoenix/tree/master/docs/docs/api/19-space.md",tags:[],version:"current",sidebarPosition:19,frontMatter:{},sidebar:"sidebar",previous:{title:"Screen",permalink:"/phoenix/api/screen"},next:{title:"Mouse",permalink:"/phoenix/api/mouse"}},p=[{value:"Interface",id:"interface",children:[],level:2},{value:"Static Methods",id:"static-methods",children:[],level:2},{value:"Instance Methods",id:"instance-methods",children:[{value:"Optionals",id:"optionals",children:[],level:3}],level:2},{value:"Example",id:"example",children:[],level:2}],d={toc:p};function u(e){var n=e.components,t=(0,r.Z)(e,o);return(0,i.kt)("wrapper",(0,a.Z)({},d,t,{components:n,mdxType:"MDXLayout"}),(0,i.kt)("h1",{id:"space"},"Space"),(0,i.kt)("p",null,"Use the Space to control spaces. ",(0,i.kt)("em",{parentName:"p"},"These features are only supported on El Capitan (10.11) and upwards.")," A single window can be in multiple spaces at the same time. To move a window to a different space, remove it from any existing spaces and add it to a new one. You can switch to a space by focusing on a window in that space. Beware that a space can get stale if you keep a reference to it and it is for instance closed while you do so."),(0,i.kt)("h2",{id:"interface"},"Interface"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-javascript"},"class Space implements Identifiable, Iterable\n\n  static Space active() // macOS 10.11+\n  static Array<Space> all() // macOS 10.11+\n\n  boolean isNormal()\n  boolean isFullScreen()\n  Array<Screen> screens()\n  Array<Window> windows(Map<String, AnyObject> optionals)\n  void addWindows(Array<Window> windows)\n  void removeWindows(Array<Window> windows)\n\nend\n")),(0,i.kt)("h2",{id:"static-methods"},"Static Methods"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"active()")," returns the space containing the window with the keyboard focus (macOS 10.11+, returns ",(0,i.kt)("inlineCode",{parentName:"li"},"undefined")," otherwise)"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"all()")," returns all spaces, the first space in this array corresponds to the primary space (macOS 10.11+, returns an empty list otherwise)")),(0,i.kt)("h2",{id:"instance-methods"},"Instance Methods"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"isNormal()")," returns ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," if the space is a normal space"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"isFullScreen()")," returns ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," if the space is a full screen space"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"screens()")," returns all screens to which the space belongs to"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"windows(Map<String, AnyObject> optionals)")," returns all windows for the space if no optionals are given"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"addWindows(Array<Window> windows)")," adds the given windows to the space"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"removeWindows(Array<Window> windows)")," removes the given windows from the space")),(0,i.kt)("h3",{id:"optionals"},"Optionals"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"visible")," (boolean): if set ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," returns all visible windows for the space, if set ",(0,i.kt)("inlineCode",{parentName:"li"},"false")," returns all hidden windows for the space")),(0,i.kt)("h2",{id:"example"},"Example"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-javascript"},"// Move focused window to the next space\nconst space = Space.active();\nconst window = Window.focused();\nspace.next().addWindows([window]);\nspace.removeWindows([window]);\nwindow.focus();\n")))}u.isMDXComponent=!0}}]);