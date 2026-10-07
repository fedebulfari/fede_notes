<% let noteType = await tp.system.suggester(["lecture","exercise"])%>
---
date: <% tp.file.creation_date("DD-MM-YYYY") %>
subject: <% tp.file.folder(false) %>
tags: [<% noteType %>]
---
# <% tp.file.title %>

---
**Related** [[_<% tp.file.folder(false) %>_MOC]]