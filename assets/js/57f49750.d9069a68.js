"use strict";(self.webpackChunk_phoenix_docs=self.webpackChunk_phoenix_docs||[]).push([[818],{3905:(e,t,n)=>{n.d(t,{Zo:()=>u,kt:()=>f});var a=n(7294);function i(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function r(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function l(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?r(Object(n),!0).forEach((function(t){i(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):r(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function o(e,t){if(null==e)return{};var n,a,i=function(e,t){if(null==e)return{};var n,a,i={},r=Object.keys(e);for(a=0;a<r.length;a++)n=r[a],t.indexOf(n)>=0||(i[n]=e[n]);return i}(e,t);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);for(a=0;a<r.length;a++)n=r[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(i[n]=e[n])}return i}var p=a.createContext({}),s=function(e){var t=a.useContext(p),n=t;return e&&(n="function"==typeof e?e(t):l(l({},t),e)),n},u=function(e){var t=s(e.components);return a.createElement(p.Provider,{value:t},e.children)},d="mdxType",c={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},m=a.forwardRef((function(e,t){var n=e.components,i=e.mdxType,r=e.originalType,p=e.parentName,u=o(e,["components","mdxType","originalType","parentName"]),d=s(n),m=i,f=d["".concat(p,".").concat(m)]||d[m]||c[m]||r;return n?a.createElement(f,l(l({ref:t},u),{},{components:n})):a.createElement(f,l({ref:t},u))}));function f(e,t){var n=arguments,i=t&&t.mdxType;if("string"==typeof e||i){var r=n.length,l=new Array(r);l[0]=m;var o={};for(var p in t)hasOwnProperty.call(t,p)&&(o[p]=t[p]);o.originalType=e,o[d]="string"==typeof e?e:i,l[1]=o;for(var s=2;s<r;s++)l[s]=n[s];return a.createElement.apply(null,l)}return a.createElement.apply(null,n)}m.displayName="MDXCreateElement"},9463:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>p,contentTitle:()=>l,default:()=>c,frontMatter:()=>r,metadata:()=>o,toc:()=>s});var a=n(7462),i=(n(7294),n(3905));const r={},l="App",o={unversionedId:"api/app",id:"api/app",title:"App",description:"Use App to control apps. Beware that an app can get stale if you keep a reference to it and it is for instance terminated while you do so, refer to isTerminated().",source:"@site/docs/api/21-app.md",sourceDirName:"api",slug:"/api/app",permalink:"/phoenix/api/app",draft:!1,editUrl:"https://github.com/kasper/phoenix/tree/master/docs/docs/api/21-app.md",tags:[],version:"current",sidebarPosition:21,frontMatter:{},sidebar:"sidebar",previous:{title:"Mouse",permalink:"/phoenix/api/mouse"},next:{title:"Window",permalink:"/phoenix/api/window"}},p={},s=[{value:"Interface",id:"interface",level:2},{value:"Static Methods",id:"static-methods",level:2},{value:"Launch Optionals",id:"launch-optionals",level:3},{value:"Instance Methods",id:"instance-methods",level:2},{value:"Window Optionals",id:"window-optionals",level:3},{value:"Terminate Optionals",id:"terminate-optionals",level:3},{value:"Example",id:"example",level:2}],u={toc:s},d="wrapper";function c(e){let{components:t,...n}=e;return(0,i.kt)(d,(0,a.Z)({},u,n,{components:t,mdxType:"MDXLayout"}),(0,i.kt)("h1",{id:"app"},"App"),(0,i.kt)("p",null,"Use App to control apps. Beware that an app can get stale if you keep a reference to it and it is for instance terminated while you do so, refer to ",(0,i.kt)("inlineCode",{parentName:"p"},"isTerminated()"),"."),(0,i.kt)("h2",{id:"interface"},"Interface"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-javascript"},"class App implements Identifiable\n\n  static App get(String appName)\n  static App launch(String appName, Map<String, AnyObject> optionals)\n  static App focused()\n  static Array<App> all()\n\n  int processIdentifier()\n  String bundleIdentifier()\n  String name()\n  Image icon()\n  boolean isActive()\n  boolean isHidden()\n  boolean isTerminated()\n  Window mainWindow()\n  Array<Window> windows(Map<String, AnyObject> optionals)\n  boolean activate()\n  boolean focus()\n  boolean show()\n  boolean hide()\n  boolean terminate(Map<String, AnyObject> optionals)\n\nend\n")),(0,i.kt)("h2",{id:"static-methods"},"Static Methods"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"get(String appName)")," returns the running app with the given name, returns ",(0,i.kt)("inlineCode",{parentName:"li"},"undefined")," if the app is not currently running"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"launch(String appName, Map<String, AnyObject> optionals)")," launches and returns the app with the given name, returns ",(0,i.kt)("inlineCode",{parentName:"li"},"undefined")," if unsuccessful"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"focused()")," returns the focused app"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"all()")," returns all running apps")),(0,i.kt)("h3",{id:"launch-optionals"},"Launch Optionals"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"focus")," (boolean): if set ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," the app will automatically be focused on launch, by default the app launches to the background")),(0,i.kt)("h2",{id:"instance-methods"},"Instance Methods"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"processIdentifier()")," returns the process identifier (PID) for the app, returns ",(0,i.kt)("inlineCode",{parentName:"li"},"-1")," if the app does not have a PID"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"bundleIdentifier()")," returns the bundle identifier for the app"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"name()")," returns the name for the app"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"icon()")," returns the icon for the app"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"isActive()")," returns ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," if the app is currently frontmost"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"isHidden()")," returns ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," if the app is hidden"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"isTerminated()")," returns ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," if the app has been terminated"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"mainWindow()")," returns the main window for the app, returns ",(0,i.kt)("inlineCode",{parentName:"li"},"undefined")," if the app does not currently have a main window"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"windows(Map<String, AnyObject> optionals)")," returns all windows for the app if no optionals are given"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"activate()")," activates the app and brings its windows forward, returns ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"focus()")," activates the app and brings its windows to focus, returns ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"show()")," shows the app, returns ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"hide()")," hides the app, returns ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," if successful"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"terminate(Map<String, AnyObject> optionals)")," terminates the app, returns ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," if successful")),(0,i.kt)("h3",{id:"window-optionals"},"Window Optionals"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"visible")," (boolean): if set ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," returns all visible windows for the app, if set ",(0,i.kt)("inlineCode",{parentName:"li"},"false")," returns all hidden windows for the app")),(0,i.kt)("h3",{id:"terminate-optionals"},"Terminate Optionals"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"force")," (boolean): if set ",(0,i.kt)("inlineCode",{parentName:"li"},"true")," force terminates the app")),(0,i.kt)("h2",{id:"example"},"Example"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-javascript"},"// Launch Safari with focus\nApp.launch('Safari', { focus: true });\n\n// Get the focused app\nconst focused = App.focused();\n\n// Get all windows for the focused app\nconst windows = focused.windows();\n\n// Get Safari\nconst safari = App.get('Safari');\n")))}c.isMDXComponent=!0}}]);