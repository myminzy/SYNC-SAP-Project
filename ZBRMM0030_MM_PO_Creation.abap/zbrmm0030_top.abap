<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBRMM0030_TOP</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBRMM0030_TOP</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include ZBRMM0030_TOP</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          ZBRMM0030_TOP</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>

TABLES: ZTBMM0020, ZTBMM0021, ZTBSD1030, ZTBMM0010, ZTBMM0011.


TYPE-POOLS: SLIS.

DATA: OK_CODE TYPE SY-UCOMM.

<font color ="#0000FF">*SELECT-OPTIONS - PONUM,DATA</font>
DATA: RT_PRNUM TYPE RANGE OF ZTBMM0010-PRNUM,
      RS_PRNUM LIKE LINE OF RT_PRNUM.

<font color ="#0000FF">*ZSBMM0020_ALV1   -&gt;  구매요청 헤더 & 아이템 모든 필드</font>
<font color ="#0000FF">*ZSBMM0020_PO     -&gt; 구매오더 헤더 & 아이템 모든 필드</font>

"100
"구매요청 헤더 + 아이템 - 신호등
TYPES: BEGIN OF GTY_ZTBMM0010.
         include structure <a href ="zsbmm0020_alv1/dictionary-zsbmm0020_alv1.html">ZSBMM0020_ALV1</a>.
TYPES: LIGHT TYPE C LENGTH 1. "신호등
TYPES: END OF GTY_ZTBMM0010.

"구매요청 헤더 + 아이템
DATA: GT_ZTBMM0010 TYPE TABLE OF GTY_ZTBMM0010,
      GS_ZTBMM0010 TYPE GTY_ZTBMM0010.


"DB
"구매오더 헤더 + 아이템 - 신호등
TYPES: BEGIN OF GTY_ZTBMM0020.
  include structure <a href ="zsbmm0020_po/dictionary-zsbmm0020_po.html">ZSBMM0020_PO</a>.
<font color ="#0000FF">*TYPES: LIGHT20 TYPE C LENGTH 1. "신호등</font>
TYPES: END OF GTY_ZTBMM0020.

"구매오더 헤더 + 아이템
DATA: GT_ZTBMM0020 TYPE TABLE OF GTY_ZTBMM0020,
      GS_ZTBMM0020 TYPE GTY_ZTBMM0020.

"ALV DOCKING
DATA: GO_DOCK TYPE REF TO CL_GUI_DOCKING_CONTAINER,
      GO_ALV1 TYPE REF TO CL_GUI_ALV_GRID,
      GO_ALV2 TYPE REF TO CL_GUI_ALV_GRID.

"ALV DOCKING SPLIT
DATA: GO_SPLIT TYPE REF TO CL_GUI_SPLITTER_CONTAINER,
      GO_TOP   TYPE REF TO CL_GUI_CONTAINER,
      GO_BOT   TYPE REF TO CL_GUI_CONTAINER.

"ALV LAYOUT
DATA: LS_LAYOUT1 TYPE LVC_S_LAYO,
      LS_LAYOUT2 TYPE LVC_S_LAYO,
      LT_FCAT1   TYPE LVC_T_FCAT,
      LS_FCAT1   TYPE LVC_S_FCAT,
      LT_FCAT2   TYPE LVC_T_FCAT,
      LS_FCAT2   TYPE LVC_S_FCAT.

"ALV DOCKING 200
DATA: GO_DOCK200 TYPE REF TO CL_GUI_DOCKING_CONTAINER,
      GO_ALV200  TYPE REF TO CL_GUI_ALV_GRID.

DATA: LS_LAYOUT200 TYPE LVC_S_LAYO,
      LT_FCAT200   TYPE LVC_T_FCAT,
      LS_FCAT200   TYPE LVC_S_FCAT.

"GET SEL 200
DATA: SEL_IDX TYPE I.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
