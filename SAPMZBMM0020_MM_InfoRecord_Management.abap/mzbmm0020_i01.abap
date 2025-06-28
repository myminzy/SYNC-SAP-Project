<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>MZBMM0020_I01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: MZBMM0020_I01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include MZBMM0020_I01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          MZBMM0020_I01</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  USER_COMMAND_0100  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE USER_COMMAND_0100 INPUT.
  CASE OK_CODE.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.


    WHEN 'CREATE'.
      CALL SCREEN 110
      STARTING AT 5 5.

    WHEN 'MODIFY'.
      PERFORM ZBMM_MODIFY.

    WHEN 'SHR_BTN'.
      PERFORM ZBMM_GET_DATA_0100.
  ENDCASE.

ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_CREATE_BTN</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_CREATE_BTN .

ENDFORM.

<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  USER_COMMAND_0110  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE USER_COMMAND_0110 INPUT.
  CASE OK_CODE.
    WHEN 'OKAY'.
      PERFORM ZBMM_CREATE_SAVE. "데이터 저장
      LEAVE TO SCREEN 0.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  EXIT_0120  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE EXIT_0120 INPUT.
  CASE OK_CODE.
    WHEN 'EXIT' OR 'CANCEL'.
<font color ="#0000FF">*      CLEAR: ZTBMM1020-PLTCODE, ZTBMM1020-PLTNAME.</font>
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      Module  USER_COMMAND_0120  INPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*       text</font>
<font color ="#0000FF">*----------------------------------------------------------------------*</font>
MODULE USER_COMMAND_0120 INPUT.
  CASE OK_CODE.
    WHEN 'OKAY120'.
      PERFORM ZBMM_MODIFY_SAVE.
        LEAVE TO SCREEN 0.
    WHEN 'CANCEL120'.
        LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
