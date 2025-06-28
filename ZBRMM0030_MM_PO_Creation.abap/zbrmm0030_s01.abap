<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBRMM0030_S01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBRMM0030_S01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include ZBRMM0030_S01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          ZBRMM0030_S01</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>

SELECTION-SCREEN BEGIN OF BLOCK BLK1 WITH FRAME TITLE TEXT-T01.
<font color ="#0000FF">*  PARAMETERS: PR_NUM TYPE ZTBMM0010-PRNUM MATCHCODE OBJECT ZSHB_PRNUM.</font>

  "NO-EXTENSION: 노란색 박스 없애기  NO INTERVALS : TO 박스 없애기.
  SELECT-OPTIONS : PR_NUM FOR ZTBMM0010-PRNUM NO-EXTENSION NO INTERVALS.
  SELECT-OPTIONS : SO_DAT FOR ZTBMM0010-PRDATE.
SELECTION-SCREEN END OF BLOCK BLK1.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
