<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBBMM0020_O01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBBMM0020_O01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include ZBBMM0020_O01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          ZBBMM0020_O01</font>
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
<font color ="#0000FF">*& Module CLEAR_OKCODE OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE CLEAR_OKCODE OUTPUT.
  CLEAR: OK_CODE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module INIT_ALV OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE INIT_ALV OUTPUT.

  IF GO_DOCK IS INITIAL.

    CREATE OBJECT GO_DOCK
      EXPORTING
        REPID                       = SY-REPID
        DYNNR                       = SY-DYNNR
        SIDE                        = CL_GUI_DOCKING_CONTAINER=&gt;DOCK_AT_TOP
        EXTENSION                   = 1000
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
        I_PARENT                = GO_DOCK
      EXCEPTIONS
        ERROR_CNTL_CREATE       = 1
        ERROR_CNTL_INIT         = 2
        ERROR_CNTL_LINK         = 3
        ERROR_DP_CREATE         = 4
        OTHERS                  = 5.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

    PERFORM ZBMM_SET_LAYO.
    PERFORM ZBMM_SET_FCAT.

    CALL METHOD GO_ALV-&gt;SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
        I_BYPASSING_BUFFER            = 'X'
        I_STRUCTURE_NAME              = 'ZTBMM0070'
        IS_LAYOUT                     =  GS_LAYO
      CHANGING
        IT_OUTTAB                     = GT_DATA
        IT_FIELDCATALOG               = GT_FCAT
<font color ="#0000FF">*        IT_SORT                       =</font>
<font color ="#0000FF">*        IT_FILTER                     =</font>
      EXCEPTIONS
        INVALID_PARAMETER_COMBINATION = 1
        PROGRAM_ERROR                 = 2
        TOO_MANY_LINES                = 3
        OTHERS                        = 4
      .
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.
  ENDIF.

ENDMODULE.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
