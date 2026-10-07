<%* 
let noteType = await tp.system.suggester(["Lecture", "Exercise"], ["lecture", "exercise"]); 
_%>
---
date: <% tp.file.creation_date("DD-MM-YYYY") %>
subject: <% tp.file.folder(false) %>
tags: [<% noteType %>]
---



---
Related: [[_<% tp.file.folder(false) %>_MOC]]