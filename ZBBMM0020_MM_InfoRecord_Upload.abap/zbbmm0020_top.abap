<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBBMM0020_TOP</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBBMM0020_TOP</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include ZBBMM0020_TOP</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          ZBBMM0020_TOP</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>

" SELECTION SCREEN APPLICATION TOOLBAR BUTTON 생성.
TABLES: SSCRFIELDS.

DATA: OK_CODE TYPE SY-UCOMM.

"인포레코드 TABLE
DATA : GS_ZTBMM0070 TYPE ZTBMM0070,
       GT_ZTBMM0070 TYPE TABLE OF ZTBMM0070.

"EXCEL 변수
DATA : GT_FILE        TYPE FILETABLE,       "FILE NAME
       GS_FILE        LIKE LINE OF GT_FILE,
       GV_RC_FILEPATH TYPE I.


" 엑셀 양식과 동일하게 타입 설정.
" MANDT, INFNUM(인포레코드 번호),DELFLG는 입력하지 않고, EXCEL 데이터 저장 시 값 할당.
<font color ="#0000FF">*TYPES : BEGIN OF TS_DATA,</font>
<font color ="#0000FF">*          MANDT    TYPE MANDT,</font>
<font color ="#0000FF">*          MATCODE  TYPE ZEB_MATCODE,</font>
<font color ="#0000FF">*          BPCODE   TYPE ZEB_BPCODE,</font>
<font color ="#0000FF">**          INFQUANT TYPE ZEB_INFQUANT,</font>
<font color ="#0000FF">*          INFQUANT TYPE CHAR10,</font>
<font color ="#0000FF">*          UNITCODE TYPE ZEB_UNITCODE,</font>
<font color ="#0000FF">**          INFPRICE TYPE ZEB_INFPRICE,</font>
<font color ="#0000FF">*          INFPRICE TYPE CHAR10,</font>
<font color ="#0000FF">*          CURRENCY TYPE ZEB_CURRCODE,</font>
<font color ="#0000FF">*          LDTIME   TYPE ZEB_LDTIME,</font>
<font color ="#0000FF">**          ZTERM    TYPE ZEB_ZTERM,</font>
<font color ="#0000FF">**          DATSR    TYPE ZEB_DATSR,</font>
<font color ="#0000FF">*          DATSR    TYPE CHAR8,</font>
<font color ="#0000FF">*          DATEN    TYPE CHAR8,</font>
<font color ="#0000FF">*        END OF TS_DATA.</font>

TYPES : BEGIN OF TS_DATA,
<font color ="#0000FF">*          MANDT    TYPE MANDT,</font>
          MATCODE  TYPE ZEB_MATCODE,
          BPCODE   TYPE ZEB_BPCODE,
          INFQUANT TYPE ZEB_INFQUANT,
          UNITCODE TYPE ZEB_UNITCODE,
          INFPRICE TYPE ZEB_INFPRICE,
          CURRENCY TYPE ZEB_CURRCODE,
          LDTIME   TYPE ZEB_LDTIME,
          ZTERM    TYPE ZEB_ZTERM,
          DATSR    TYPE ZEB_DATSR,
          DATEN    TYPE ZEB_DATEN,
        END OF TS_DATA.
" TS_DATA 타입의 INTERNAL TABLE & WORK AREA 선언.
DATA: GT_DATA TYPE TABLE OF TS_DATA,
      GS_DATA LIKE LINE OF GT_DATA.

" ALV 100
DATA: GO_DOCK TYPE REF TO CL_GUI_DOCKING_CONTAINER,
      GO_ALV  TYPE REF TO CL_GUI_ALV_GRID,
      GS_LAYO TYPE LVC_S_LAYO,
      GS_FCAT TYPE LVC_S_FCAT,
      GT_FCAT TYPE LVC_T_FCAT.

"MANDT / INFNUM / DELFLG 는 추후에 따로 넣어줌
TYPES: BEGIN OF TS_STR,
         MANDT  TYPE ZTBMM0070-MANDT,
         INFNUM TYPE ZTBMM0070-INFNUM,
         DELFLG TYPE ZTBMM0070-DELFLG,
       END OF TS_STR.

DATA: GS_STR TYPE TS_STR,
      GT_STR TYPE TABLE OF TS_STR.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
