<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>MZBMM0020_O01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: MZBMM0020_O01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include MZBMM0020_O01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          MZBMM0020_O01</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>

<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module STATUS_0100 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE STATUS_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module OK_CODE_0100 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE OK_CODE_0100 OUTPUT.
  CLEAR: OK_CODE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module SET_ALV_0100 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE SET_ALV_0100 OUTPUT.

  IF GO_CONT IS INITIAL.

    CREATE OBJECT GO_CONT
      EXPORTING
        CONTAINER_NAME              = 'CONT'
      EXCEPTIONS
        CNTL_ERROR                  = 1
        CNTL_SYSTEM_ERROR           = 2
        CREATE_ERROR                = 3
        LIFETIME_ERROR              = 4
        LIFETIME_DYNPRO_DYNPRO_LINK = 5
        OTHERS                      = 6.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.


    CREATE OBJECT GO_ALV
      EXPORTING
        I_PARENT          = GO_CONT
      EXCEPTIONS
        ERROR_CNTL_CREATE = 1
        ERROR_CNTL_INIT   = 2
        ERROR_CNTL_LINK   = 3
        ERROR_DP_CREATE   = 4
        OTHERS            = 5.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

    PERFORM ZBMM_SET_LAYOUT.
    PERFORM ZBMM_SET_FCAT.

    CALL METHOD GO_ALV-&gt;SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
        I_STRUCTURE_NAME              = 'ZTBMM0070'
        I_DEFAULT                     = 'X'
        IS_LAYOUT                     = GS_LAYOUT
      CHANGING
        IT_OUTTAB                     = GT_ZTBMM0070
        IT_FIELDCATALOG               = GT_FCAT
<font color ="#0000FF">*       IT_SORT                       =</font>
<font color ="#0000FF">*       IT_FILTER                     =</font>
      EXCEPTIONS
        INVALID_PARAMETER_COMBINATION = 1
        PROGRAM_ERROR                 = 2
        TOO_MANY_LINES                = 3
        OTHERS                        = 4.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

  ELSE.

    "ALV DISPLAY!!
    CALL METHOD GO_ALV-&gt;REFRESH_TABLE_DISPLAY
      EXCEPTIONS
        FINISHED = 1
        OTHERS   = 2.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

  ENDIF.

ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module STATUS_0110 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE STATUS_0110 OUTPUT.
  SET PF-STATUS 'S110'.
  SET TITLEBAR 'T110'.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module OK_CODE_0110 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE OK_CODE_0110 OUTPUT.
  CLEAR: OK_CODE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module STATUS_0120 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE STATUS_0120 OUTPUT.
  SET PF-STATUS 'S120'.
  SET TITLEBAR 'T120'.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module OK_CODE_0120 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE OK_CODE_0120 OUTPUT.
  CLEAR: OK_CODE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module SET_FIELD OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE SET_FIELD OUTPUT.

  MOVE-CORRESPONDING GS_ZTBMM0070 TO ZTBMM0070."인포레코드 MASTSER
  MOVE-CORRESPONDING GS_ZTBMM1011 TO ZTBMM1011."BP TEXT
  MOVE-CORRESPONDING GS_ZTBSD1050 TO ZTBSD1050."재재 TEXT

ENDMODULE.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
