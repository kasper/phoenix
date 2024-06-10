"use strict";(self.webpackChunk_phoenix_docs=self.webpackChunk_phoenix_docs||[]).push([[667],{6009:(e,i,t)=>{t.r(i),t.d(i,{assets:()=>l,contentTitle:()=>a,default:()=>d,frontMatter:()=>o,metadata:()=>s,toc:()=>c});var r=t(4848),n=t(8453);const o={},a="Require",s={id:"api/require",title:"Require",description:"You can modularise your configuration using the require function. It will load the referenced JavaScript file and reload it if any changes are detected. If the path is relative, it is resolved relatively to the absolute location of the primary configuration file. If this file is a symlink, it will be resolved before resolving the location of the required file. If the file does not exist, require will throw an error.",source:"@site/docs/api/require.md",sourceDirName:"api",slug:"/api/require",permalink:"/phoenix/api/require",draft:!1,unlisted:!1,editUrl:"https://github.com/kasper/phoenix/tree/master/docs/docs/api/require.md",tags:[],version:"current",frontMatter:{},sidebar:"sidebar",previous:{title:"Rectangle",permalink:"/phoenix/api/rectangle"},next:{title:"Screen",permalink:"/phoenix/api/screen"}},l={},c=[];function u(e){const i={code:"code",h1:"h1",p:"p",pre:"pre",...(0,n.R)(),...e.components};return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(i.h1,{id:"require",children:"Require"}),"\n",(0,r.jsxs)(i.p,{children:["You can modularise your configuration using the ",(0,r.jsx)(i.code,{children:"require"})," function. It will load the referenced JavaScript file and reload it if any changes are detected. If the path is relative, it is resolved relatively to the absolute location of the primary configuration file. If this file is a symlink, it will be resolved before resolving the location of the required file. If the file does not exist, ",(0,r.jsx)(i.code,{children:"require"})," will throw an error."]}),"\n",(0,r.jsx)(i.pre,{children:(0,r.jsx)(i.code,{className:"language-javascript",children:"require('path/to/file.js');\n"})}),"\n",(0,r.jsx)(i.p,{children:"All required code is executed in the same namespace. Be careful about the execution order and polluting properties."})]})}function d(e={}){const{wrapper:i}={...(0,n.R)(),...e.components};return i?(0,r.jsx)(i,{...e,children:(0,r.jsx)(u,{...e})}):u(e)}},8453:(e,i,t)=>{t.d(i,{R:()=>a,x:()=>s});var r=t(6540);const n={},o=r.createContext(n);function a(e){const i=r.useContext(o);return r.useMemo((function(){return"function"==typeof e?e(i):{...i,...e}}),[i,e])}function s(e){let i;return i=e.disableParentContext?"function"==typeof e.components?e.components(n):e.components||n:a(e.components),r.createElement(o.Provider,{value:i},e.children)}}}]);