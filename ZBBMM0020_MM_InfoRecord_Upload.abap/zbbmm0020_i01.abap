<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBBMM0020_I01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBBMM0020_I01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include ZBBMM0020_I01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          ZBBMM0020_I01</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  EXIT  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE EXIT INPUT.
  CASE OK_CODE.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  USER_COMMAND_0100  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    "엑셀 업로드 데이터 저장
    WHEN 'SAVE'.
      PERFORM ZBMM_SAVE_EXCEL.
      LEAVE TO SCREEN 0.

    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
