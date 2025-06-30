<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>MZBSD0080_O01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: MZBSD0080_O01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include MZBSD0080_O01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          MZBSD0080_O01</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module STATUS_0100 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE STATUS_0100 OUTPUT.

 SET PF-STATUS 'S100'.
 SET TITLEBAR 'T100'.

  IF ZSBMM1020-VALID IS INITIAL AND ZSBMM1020-ALL IS INITIAL AND ZSBMM1020-DELETED IS INITIAL.
    ZSBMM1020-VALID = 'X'.
  ENDIF.


ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module INIT_ALV OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE INIT_ALV OUTPUT.

  IF GO_CONT IS INITIAL.

    CREATE OBJECT GO_CONT
      EXPORTING
        CONTAINER_NAME              =  'AREA'               " Name of the Screen CustCtrl Name to Link Container To
      EXCEPTIONS
        CNTL_ERROR                  = 1                " CNTL_ERROR
        CNTL_SYSTEM_ERROR           = 2                " CNTL_SYSTEM_ERROR
        CREATE_ERROR                = 3                " CREATE_ERROR
        LIFETIME_ERROR              = 4                " LIFETIME_ERROR
        LIFETIME_DYNPRO_DYNPRO_LINK = 5                " LIFETIME_DYNPRO_DYNPRO_LINK
        OTHERS                      = 6.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.


    CREATE OBJECT GO_ALV
      EXPORTING
        I_PARENT                 =    GO_CONT             " Parent Container
      EXCEPTIONS
        ERROR_CNTL_CREATE       = 1                " Error when creating the control
        ERROR_CNTL_INIT         = 2                " Error While Initializing Control
        ERROR_CNTL_LINK         = 3                " Error While Linking Control
        ERROR_DP_CREATE         = 4                " Error While Creating DataProvider Control
        OTHERS                  = 5.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

    PERFORM ZBSD_SET_LAYOUT. "ALV 레이아웃 설정
    PERFORM ZBSD_SET_FCAT.
    PERFORM ZBSD_SET_SORT.

    SET HANDLER LCL_EVENT_HANDLER=&gt;ON_HOTSPOT_CLICK FOR GO_ALV.

    CALL METHOD GO_ALV-&gt;SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
<font color ="#0000FF">*        i_buffer_active               =                  " Buffering Active</font>
<font color ="#0000FF">*        i_bypassing_buffer            =                  " Switch Off Buffer</font>
<font color ="#0000FF">*        i_consistency_check           =                  " Starting Consistency Check for Interface Error Recognition</font>
        I_STRUCTURE_NAME               =  'ZTBMM1020'              " Internal Output Table Structure Name
<font color ="#0000FF">*        is_variant                    =                  " Layout</font>
<font color ="#0000FF">*        i_save                        =                  " Save Layout</font>
        i_default                      =  'X'              " Default Display Variant
        IS_LAYOUT                      =  GS_LAYOUT              " Layout
<font color ="#0000FF">*        is_print                      =                  " Print Control</font>
<font color ="#0000FF">*        it_special_groups             =                  " Field Groups</font>
<font color ="#0000FF">*        it_toolbar_excluding          =                  " Excluded Toolbar Standard Functions</font>
<font color ="#0000FF">*        it_hyperlink                  =                  " Hyperlinks</font>
<font color ="#0000FF">*        it_alv_graphics               =                  " Table of Structure DTC_S_TC</font>
<font color ="#0000FF">*        it_except_qinfo               =                  " Table for Exception Quickinfo</font>
<font color ="#0000FF">*        ir_salv_adapter               =                  " Interface ALV Adapter</font>
      CHANGING
        IT_OUTTAB                      =   GT_ZTBMM1020             " Output Table
        it_fieldcatalog                =   GT_FCAT              " Field Catalog
        it_sort                        =   GT_SORT              " Sort Criteria
<font color ="#0000FF">*        it_filter                     =                  " Filter Criteria</font>
      EXCEPTIONS
        INVALID_PARAMETER_COMBINATION = 1                " Wrong Parameter
        PROGRAM_ERROR                 = 2                " Program Errors
        TOO_MANY_LINES                = 3                " Too many Rows in Ready for Input Grid
        OTHERS                        = 4.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

  ELSE.

   "ALV 레이아웃은 그대로 유지하면서 REFRESH!!
   CALL METHOD GO_ALV-&gt;REFRESH_TABLE_DISPLAY
      EXCEPTIONS
        FINISHED = 1
        OTHERS   = 2.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.


  ENDIF.



ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module CLEAR_OK_CODE OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE CLEAR_OK_CODE OUTPUT.
  CLEAR: OK_CODE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module INIT_CREATE OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE INIT_CREATE OUTPUT.

<font color ="#0000FF">*  로그인 ID로 사원마스터에 사원ID 가져오기</font>
  SELECT *
    FROM ZTBSD1030
    INTO TABLE GT_ZTBSD1030.

  READ TABLE GT_ZTBSD1030 INTO GS_ZTBSD1030 WITH KEY LOGID = SY-UNAME.
  IF SY-SUBRC = 0.
    EMPID110 = GS_ZTBSD1030-EMPID.
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
<font color ="#0000FF">*& Module STATUS_0120 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE STATUS_0120 OUTPUT.
 SET PF-STATUS 'S120'.
 SET TITLEBAR 'T120'.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module SET_FIELD OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE SET_FIELD OUTPUT.

" 팝업창으로 필드값 띄우는것
<font color ="#0000FF">*  ZTBMM1020-PLTCODE = GS_ZTBMM1020-PLTCODE.</font>
  MOVE-CORRESPONDING GS_ZTBMM1020 TO ZTBMM1020.


ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module STATUS_0130 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE STATUS_0130 OUTPUT.
 SET PF-STATUS 'S130'.
 SET TITLEBAR 'T130'.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module GET_EMP_DATA OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE GET_EMP_DATA OUTPUT.
  SELECT SINGLE *
    FROM ZTBSD1030
    WHERE EMPID = GV_EMPID.
<font color ="#0000FF">*    내가 클릭한 ID와 똑같은 한줄만 가져온다.</font>
<font color ="#0000FF">*    INTO가 없는 이유: 이필드가 해당하는 걸 130번에 넣어높음 - 스크린 페이터에 이미</font>
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module REFRESH_DATA OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE REFRESH_DATA OUTPUT.
    CLEAR:  PLTCODE110, PLTNAME110, PLTADNR110, EMPID110, GS_ZTBMM1020.
<font color ="#0000FF">*</font>
    " ALV REFRESH -&gt; 변경 사항 적용해서 화면에 보여주기 위함
      CALL METHOD GO_ALV-&gt;REFRESH_TABLE_DISPLAY
        EXCEPTIONS
          FINISHED = 1
          OTHERS   = 2.
      IF SY-SUBRC &lt;&gt; 0.
      ENDIF.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module CLEAR_OKCODE OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE CLEAR_OKCODE OUTPUT.
 CLEAR : OK_CODE.
ENDMODULE.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
