"use strict";(self.webpackChunk_phoenix_docs=self.webpackChunk_phoenix_docs||[]).push([[971],{3905:function(e,t,n){n.d(t,{Zo:function(){return c},kt:function(){return h}});var i=n(7294);function r(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);t&&(i=i.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,i)}return n}function a(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){r(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,i,r=function(e,t){if(null==e)return{};var n,i,r={},o=Object.keys(e);for(i=0;i<o.length;i++)n=o[i],t.indexOf(n)>=0||(r[n]=e[n]);return r}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(i=0;i<o.length;i++)n=o[i],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(r[n]=e[n])}return r}var s=i.createContext({}),p=function(e){var t=i.useContext(s),n=t;return e&&(n="function"==typeof e?e(t):a(a({},t),e)),n},c=function(e){var t=p(e.components);return i.createElement(s.Provider,{value:t},e.children)},u={inlineCode:"code",wrapper:function(e){var t=e.children;return i.createElement(i.Fragment,{},t)}},d=i.forwardRef((function(e,t){var n=e.components,r=e.mdxType,o=e.originalType,s=e.parentName,c=l(e,["components","mdxType","originalType","parentName"]),d=p(n),h=r,m=d["".concat(s,".").concat(h)]||d[h]||u[h]||o;return n?i.createElement(m,a(a({ref:t},c),{},{components:n})):i.createElement(m,a({ref:t},c))}));function h(e,t){var n=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var o=n.length,a=new Array(o);a[0]=d;var l={};for(var s in t)hasOwnProperty.call(t,s)&&(l[s]=t[s]);l.originalType=e,l.mdxType="string"==typeof e?e:r,a[1]=l;for(var p=2;p<o;p++)a[p]=n[p];return i.createElement.apply(null,a)}return i.createElement.apply(null,n)}d.displayName="MDXCreateElement"},1269:function(e,t,n){n.r(t),n.d(t,{frontMatter:function(){return l},contentTitle:function(){return s},metadata:function(){return p},toc:function(){return c},default:function(){return d}});var i=n(7462),r=n(3366),o=(n(7294),n(3905)),a=["components"],l={sidebar_position:1},s="Phoenix",p={unversionedId:"index",id:"index",title:"Phoenix",description:"A lightweight macOS window and app manager scriptable with JavaScript. You can also easily use languages which compile to JavaScript such as TypeScript. Phoenix aims for efficiency and a very small footprint. If you like the idea of scripting your own window or app management toolkit with JavaScript, Phoenix is probably going to give you the things you want. With Phoenix you can bind keyboard shortcuts and system events, and use these to interact with macOS.",source:"@site/docs/index.md",sourceDirName:".",slug:"/",permalink:"/phoenix/",editUrl:"https://github.com/kasper/phoenix/tree/master/docs/docs/index.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"sidebar",next:{title:"Introduction",permalink:"/phoenix/getting-started/introduction"}},c=[{value:"Key Features",id:"key-features",children:[],level:2},{value:"Example Configuration",id:"example-configuration",children:[],level:2},{value:"Install",id:"install",children:[],level:2},{value:"Uninstall",id:"uninstall",children:[],level:2},{value:"JavaScript API",id:"javascript-api",children:[],level:2},{value:"Contact",id:"contact",children:[],level:2}],u={toc:c};function d(e){var t=e.components,n=(0,r.Z)(e,a);return(0,o.kt)("wrapper",(0,i.Z)({},u,n,{components:t,mdxType:"MDXLayout"}),(0,o.kt)("h1",{id:"phoenix"},"Phoenix"),(0,o.kt)("p",null,"A lightweight macOS window and app manager scriptable with JavaScript. You can also easily use languages which compile to JavaScript such as TypeScript. Phoenix aims for efficiency and a very small footprint. If you like the idea of scripting your own window or app management toolkit with JavaScript, Phoenix is probably going to give you the things you want. With Phoenix you can bind keyboard shortcuts and system events, and use these to interact with macOS."),(0,o.kt)("ul",null,(0,o.kt)("li",{parentName:"ul"},"Current version: 2.6.8 (",(0,o.kt)("a",{parentName:"li",href:"https://github.com/kasper/phoenix/blob/master/CHANGELOG.md"},"Changelog"),")"),(0,o.kt)("li",{parentName:"ul"},"Requires: macOS 10.10 or higher")),(0,o.kt)("h2",{id:"key-features"},"Key Features"),(0,o.kt)("ul",null,(0,o.kt)("li",{parentName:"ul"},"highly customisable, write your own configuration"),(0,o.kt)("li",{parentName:"ul"},"bind keyboard shortcuts and system events to your callback functions"),(0,o.kt)("li",{parentName:"ul"},"control and interact with your screens, spaces, mouse, apps and windows"),(0,o.kt)("li",{parentName:"ul"},"log messages, deliver notifications or display content as modals"),(0,o.kt)("li",{parentName:"ul"},"run external commands")),(0,o.kt)("h2",{id:"example-configuration"},"Example Configuration"),(0,o.kt)("p",null,"Below you will find a basic configuration example. Copy and paste it to ",(0,o.kt)("inlineCode",{parentName:"p"},"~/.phoenix.js"),". When you press the key combination ",(0,o.kt)("kbd",null,"Ctrl")," + ",(0,o.kt)("kbd",null,"Shift")," + ",(0,o.kt)("kbd",null,"Z")," on your keyboard, the focused window will be moved to the centre of your main screen. Happy hacking! \ud83d\udc69\ud83c\udffc\u200d\ud83d\udcbb"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-javascript"},"Key.on('z', ['ctrl', 'shift'], () => {\n  const screen = Screen.main().flippedVisibleFrame();\n  const window = Window.focused();\n\n  if (window) {\n    window.setTopLeft({\n      x: screen.x + (screen.width / 2) - (window.frame().width / 2),\n      y: screen.y + (screen.height / 2) - (window.frame().height / 2)\n    });\n  }\n});\n")),(0,o.kt)("p",null,"Phoenix lives on your status bar (or as a background daemon). Here, Phoenix is being used to move a window to different corners of the screen."),(0,o.kt)("p",null,(0,o.kt)("img",{parentName:"p",src:"https://raw.githubusercontent.com/kasper/phoenix/master/assets/screenshot.gif",alt:"Screenshot of Phoenix"})),(0,o.kt)("h2",{id:"install"},"Install"),(0,o.kt)("ul",null,(0,o.kt)("li",{parentName:"ul"},(0,o.kt)("a",{parentName:"li",href:"https://github.com/kasper/phoenix/releases/download/2.6.8/phoenix-2.6.8.tar.gz"},(0,o.kt)("strong",{parentName:"a"},"Download Phoenix"))),(0,o.kt)("li",{parentName:"ul"},"See previous ",(0,o.kt)("a",{parentName:"li",href:"https://github.com/kasper/phoenix/releases/"},"releases"))),(0,o.kt)("p",null,"To install, extract the downloaded archive and just drag-and-drop Phoenix to your ",(0,o.kt)("inlineCode",{parentName:"p"},"Applications")," folder. When you run Phoenix for the first time, you will be asked to allow it to control your UI. macOS will ask you to open ",(0,o.kt)("inlineCode",{parentName:"p"},"Security & Privacy")," in System Preferences. Once open, go to the ",(0,o.kt)("inlineCode",{parentName:"p"},"Accessibility")," section and click the checkbox next to Phoenix to enable control. An admin account is required to accomplish this."),(0,o.kt)("p",null,"Alternatively, if you have ",(0,o.kt)("a",{parentName:"p",href:"https://brew.sh"},"Homebrew")," installed, you can simply run ",(0,o.kt)("inlineCode",{parentName:"p"},"brew install --cask phoenix"),"."),(0,o.kt)("h2",{id:"uninstall"},"Uninstall"),(0,o.kt)("p",null,"To uninstall Phoenix, delete the app from your ",(0,o.kt)("inlineCode",{parentName:"p"},"Applications")," folder. The configuration file created by Phoenix itself is located in your home folder. Delete ",(0,o.kt)("inlineCode",{parentName:"p"},"~/.phoenix.js")," and any related configurations if desired."),(0,o.kt)("p",null,"Application preferences are stored in ",(0,o.kt)("inlineCode",{parentName:"p"},"~/Library/Preferences/org.khirviko.Phoenix.plist"),"."),(0,o.kt)("p",null,"If you have used the storage, also delete the file ",(0,o.kt)("inlineCode",{parentName:"p"},"~/Library/Application Support/Phoenix/storage.json"),"."),(0,o.kt)("h2",{id:"javascript-api"},"JavaScript API"),(0,o.kt)("p",null,"This documentation is an overview of the JavaScript API provided by Phoenix. Currently, the supported version of JavaScript is based on the ECMAScript 6 standard. macOS versions prior to Sierra (10.12) support ECMAScript 5.1. Use this as a guide for writing your window management script."),(0,o.kt)("p",null,"Your script should reside in ",(0,o.kt)("inlineCode",{parentName:"p"},"~/.phoenix.js"),". Alternatively \u2014 if you prefer \u2014 you may also have your script in ",(0,o.kt)("inlineCode",{parentName:"p"},"~/Library/Application Support/Phoenix/phoenix.js")," or ",(0,o.kt)("inlineCode",{parentName:"p"},"~/.config/phoenix/phoenix.js"),"."),(0,o.kt)("p",null,"Phoenix includes ",(0,o.kt)("a",{parentName:"p",href:"https://lodash.com"},"Lodash")," (4.17.15) \u2014 you can use its features in your configuration. Lodash provides useful helpers for handling JavaScript functions and objects. You may also use JavaScript ",(0,o.kt)("a",{parentName:"p",href:"getting-started/preprocessing"},"preprocessing")," and languages such as TypeScript to write your Phoenix configuration."),(0,o.kt)("h2",{id:"contact"},"Contact"),(0,o.kt)("p",null,"If you have any questions, feedback or just want to say hi, you can ",(0,o.kt)("a",{parentName:"p",href:"https://github.com/kasper/phoenix/issues/"},"open an issue"),", ",(0,o.kt)("a",{parentName:"p",href:"mailto:kasper@kytkemo.com"},"email")," or ",(0,o.kt)("a",{parentName:"p",href:"https://twitter.com/kasper/"},"tweet"),"."))}d.isMDXComponent=!0}}]);