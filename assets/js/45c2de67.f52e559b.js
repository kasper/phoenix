"use strict";(self.webpackChunk_phoenix_docs=self.webpackChunk_phoenix_docs||[]).push([[693],{3905:(e,n,t)=>{t.d(n,{Zo:()=>s,kt:()=>y});var i=t(7294);function a(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function r(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);n&&(i=i.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,i)}return t}function l(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?r(Object(t),!0).forEach((function(n){a(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):r(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function o(e,n){if(null==e)return{};var t,i,a=function(e,n){if(null==e)return{};var t,i,a={},r=Object.keys(e);for(i=0;i<r.length;i++)t=r[i],n.indexOf(t)>=0||(a[t]=e[t]);return a}(e,n);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);for(i=0;i<r.length;i++)t=r[i],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(a[t]=e[t])}return a}var p=i.createContext({}),d=function(e){var n=i.useContext(p),t=n;return e&&(t="function"==typeof e?e(n):l(l({},n),e)),t},s=function(e){var n=d(e.components);return i.createElement(p.Provider,{value:n},e.children)},k="mdxType",c={inlineCode:"code",wrapper:function(e){var n=e.children;return i.createElement(i.Fragment,{},n)}},m=i.forwardRef((function(e,n){var t=e.components,a=e.mdxType,r=e.originalType,p=e.parentName,s=o(e,["components","mdxType","originalType","parentName"]),k=d(t),m=a,y=k["".concat(p,".").concat(m)]||k[m]||c[m]||r;return t?i.createElement(y,l(l({ref:n},s),{},{components:t})):i.createElement(y,l({ref:n},s))}));function y(e,n){var t=arguments,a=n&&n.mdxType;if("string"==typeof e||a){var r=t.length,l=new Array(r);l[0]=m;var o={};for(var p in n)hasOwnProperty.call(n,p)&&(o[p]=n[p]);o.originalType=e,o[k]="string"==typeof e?e:a,l[1]=o;for(var d=2;d<r;d++)l[d]=t[d];return i.createElement.apply(null,l)}return i.createElement.apply(null,t)}m.displayName="MDXCreateElement"},3510:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>p,contentTitle:()=>l,default:()=>c,frontMatter:()=>r,metadata:()=>o,toc:()=>d});var i=t(7462),a=(t(7294),t(3905));const r={},l="Keys",o={unversionedId:"api/keys",id:"api/keys",title:"Keys",description:"All valid keys for binding are as follows:",source:"@site/docs/api/1-keys.md",sourceDirName:"api",slug:"/api/keys",permalink:"/phoenix/api/keys",draft:!1,editUrl:"https://github.com/kasper/phoenix/tree/master/docs/docs/api/1-keys.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{},sidebar:"sidebar",previous:{title:"TypeScript",permalink:"/phoenix/getting-started/typescript"},next:{title:"Events",permalink:"/phoenix/api/events"}},p={},d=[{value:"Special Keys",id:"special-keys",level:2}],s={toc:d},k="wrapper";function c(e){let{components:n,...t}=e;return(0,a.kt)(k,(0,i.Z)({},s,t,{components:n,mdxType:"MDXLayout"}),(0,a.kt)("h1",{id:"keys"},"Keys"),(0,a.kt)("p",null,"All valid keys for binding are as follows:"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("strong",{parentName:"li"},"Modifiers:")," ",(0,a.kt)("inlineCode",{parentName:"li"},"command")," (",(0,a.kt)("inlineCode",{parentName:"li"},"cmd"),"), ",(0,a.kt)("inlineCode",{parentName:"li"},"option")," (",(0,a.kt)("inlineCode",{parentName:"li"},"alt"),"), ",(0,a.kt)("inlineCode",{parentName:"li"},"control")," (",(0,a.kt)("inlineCode",{parentName:"li"},"ctrl"),") and ",(0,a.kt)("inlineCode",{parentName:"li"},"shift")," (case insensitive)"),(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("strong",{parentName:"li"},"Keys:")," case insensitive character or case sensitive special key including function keys, arrow keys, keypad keys etc. as listed below"),(0,a.kt)("li",{parentName:"ul"},"You can bind any key on your local keyboard layout, for instance an ",(0,a.kt)("inlineCode",{parentName:"li"},"\xe5")," character if your keyboard has one"),(0,a.kt)("li",{parentName:"ul"},"If you use multiple keyboard layouts, Phoenix will use the active layout when the context is loaded")),(0,a.kt)("p",null,"Use these to construct a ",(0,a.kt)("a",{parentName:"p",href:"key"},"Key"),"."),(0,a.kt)("h2",{id:"special-keys"},"Special Keys"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("strong",{parentName:"li"},"Action:")," ",(0,a.kt)("inlineCode",{parentName:"li"},"return"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"tab"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"space"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"delete"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"escape"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"help"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"home"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"pageUp"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"forwardDelete"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"end"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"pageDown"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"left"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"right"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"down")," and ",(0,a.kt)("inlineCode",{parentName:"li"},"up")),(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("strong",{parentName:"li"},"Function:")," ",(0,a.kt)("inlineCode",{parentName:"li"},"f1")," \u2013 ",(0,a.kt)("inlineCode",{parentName:"li"},"f19")),(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("strong",{parentName:"li"},"Keypad:")," ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad."),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad*"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad+"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypadClear"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad/"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypadEnter"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad-"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad="),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad0"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad1"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad2"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad3"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad4"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad5"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad6"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad7"),", ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad8")," and ",(0,a.kt)("inlineCode",{parentName:"li"},"keypad9"))))}c.isMDXComponent=!0}}]);