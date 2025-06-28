<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>MZBSD0080_TOP</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: MZBSD0080_TOP</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include MZBSD0080_TOP</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include MZBSD0080_TOP                            - Module Pool      SAPMZBSD0080</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
PROGRAM SAPMZBSD0080.

TABLES: ZTBMM1020, ZTBSD1030, ZSBMM1020.

TYPE-POOLS: slis.                                 "ALV Declarations

"OK_CODE
DATA: OK_CODE TYPE SY-UCOMM.

"DELETE
DATA: DEL TYPE CHAR1.
"삭제 팝업창
DATA: LV_ANSWER TYPE C.

"DATA 100
DATA: GT_ZTBMM1020 TYPE TABLE OF ZTBMM1020,
      GS_ZTBMM1020 TYPE ZTBMM1020.

"DATA LOGID =&gt; 사원 MASTER
DATA: GT_ZTBSD1030 TYPE TABLE OF ZTBSD1030,
      GS_ZTBSD1030 TYPE ZTBSD1030.

"DATA PLTCODE - SELECT OPTION.
DATA: RT_PLTCODE TYPE RANGE OF ZTBMM1020-PLTCODE,
      RS_PLTCODE LIKE LINE OF RT_PLTCODE.

"DATA 110
DATA: PLTCODE110 TYPE ZTBMM1020-PLTCODE,
      PLTNAME110 TYPE ZTBMM1020-PLTNAME,
      PLTADNR110 TYPE ZTBMM1020-PLTADNR,
      EMPID110 TYPE ZTBMM1020-EMPID.

"CREATE EMPID
DATA: GV_EMPID TYPE SY-UNAME.

"ALV 100
DATA: GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GO_ALV  TYPE REF TO CL_GUI_ALV_GRID.

"ALV LAYOUT
DATA: GS_LAYOUT TYPE LVC_S_LAYO,
      GT_FCAT TYPE LVC_T_FCAT.

"ALV_S_SORT
DATA: GS_SORT TYPE LVC_S_SORT,
      GT_SORT TYPE LVC_T_SORT.

"ALV 행선택
DATA: ET_INDEX_ROW TYPE LVC_T_ROW,  "ALV control: Table rows
      ES_INDEX_ROW TYPE LVC_S_ROW.  "ALV Control: Row type

"ALV SEL INDEX
DATA: SEL_IDX TYPE I.


"RADIO
DATA: RAD_1 TYPE CHAR1 VALUE 'X',
      RAD_2 TYPE CHAR1,
      RAD_3 TYPE CHAR1.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
