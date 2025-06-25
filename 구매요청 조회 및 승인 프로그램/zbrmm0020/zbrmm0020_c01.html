<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBRMM0020_C01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBRMM0020_C01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include ZBRMM0020_C01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          ZBRMM0020_C01</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>

<font color ="#0000FF">*SET HANDLER 꼭 해주기</font>
CLASS LCL_EVENT_HANDLER DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS:
      "아이템 조회 버튼
      ON_TOOLBAR1 FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
        IMPORTING E_OBJECT,
      ON_USER_COMMAND1 FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID
        IMPORTING E_UCOMM,

      "필터링 버튼 -&gt; 구매오더 완료 조회
      ON_TOOLBAR2 FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
        IMPORTING E_OBJECT,

      "필터링 버튼 -&gt; 구매오더 미완료 조회
      ON_TOOLBAR3 FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
        IMPORTING E_OBJECT,

      "필터링 버튼 -&gt; 구매오더 반려 조회
      ON_TOOLBAR5 FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
        IMPORTING E_OBJECT,

      "전체조회  버튼 -&gt; 구매오더 미완료 조회
      ON_TOOLBAR4 FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
        IMPORTING E_OBJECT,

      "사원ID 팝업창 130
      ON_HOTSPOT_CLICK FOR EVENT HOTSPOT_CLICK OF CL_GUI_ALV_GRID
        IMPORTING ES_ROW_NO E_COLUMN_ID.

ENDCLASS.

CLASS LCL_EVENT_HANDLER IMPLEMENTATION.

  "아이템 조회 버튼 CREATE
  METHOD ON_TOOLBAR1.

    LS_BUTTON-BUTN_TYPE = 3.
    APPEND LS_BUTTON TO E_OBJECT-&gt;MT_TOOLBAR.


    CLEAR: LS_BUTTON.
    LS_BUTTON-FUNCTION = 'IT_SEARCH'.
    LS_BUTTON-TEXT = 'ITEM 조회'.
<font color ="#0000FF">*    ls_button-</font>
    LS_BUTTON-BUTN_TYPE = 0.
    LS_BUTTON-ICON = ICON_ZOOM_IN.
    LS_BUTTON-QUICKINFO = 'SEARCH'.

    APPEND LS_BUTTON TO E_OBJECT-&gt;MT_TOOLBAR.
  ENDMETHOD.

  " 아이템 조회 버튼 클릭 했을때
  METHOD ON_USER_COMMAND1.
    PERFORM ZBMM_HANDLE_USER_COMMAND USING E_UCOMM.
  ENDMETHOD.

  "구매오더 완료 -&gt; 필터링 버튼 CREATE
  METHOD ON_TOOLBAR2.
    DATA: LS_BUTTON2 TYPE STB_BUTTON.
    LS_BUTTON2-BUTN_TYPE = 3.
    APPEND LS_BUTTON2 TO E_OBJECT-&gt;MT_TOOLBAR.

    CLEAR: LS_BUTTON2.
    LS_BUTTON2-FUNCTION = 'FILTER1'.
    LS_BUTTON2-TEXT = '승인'.
    LS_BUTTON2-BUTN_TYPE = 0.
    LS_BUTTON2-ICON = ICON_LED_GREEN.
    LS_BUTTON2-QUICKINFO = 'FILTER'.


    APPEND LS_BUTTON2 TO E_OBJECT-&gt;MT_TOOLBAR.
  ENDMETHOD.

  "구매오더 미완료 -&gt; 필터링 버튼 CREATE
  METHOD ON_TOOLBAR3.
    DATA: LS_BUTTON3 TYPE STB_BUTTON.
    LS_BUTTON3-BUTN_TYPE = 3.
    APPEND LS_BUTTON3 TO E_OBJECT-&gt;MT_TOOLBAR.

    CLEAR: LS_BUTTON3.
    LS_BUTTON3-FUNCTION = 'FILTER2'.
    LS_BUTTON3-TEXT = '미승인'.
    LS_BUTTON3-BUTN_TYPE = 0.
    LS_BUTTON3-ICON = ICON_LED_RED.
    LS_BUTTON3-QUICKINFO = 'FILTER'.


    APPEND LS_BUTTON3 TO E_OBJECT-&gt;MT_TOOLBAR.
  ENDMETHOD.

  "구매오더 반려 -&gt; 필터링 버튼 CREATE
  METHOD ON_TOOLBAR5.
    DATA: LS_BUTTON5 TYPE STB_BUTTON.
    LS_BUTTON5-BUTN_TYPE = 3.
    APPEND LS_BUTTON5 TO E_OBJECT-&gt;MT_TOOLBAR.

    CLEAR: LS_BUTTON5.
    LS_BUTTON5-FUNCTION = 'FILTER4'.
    LS_BUTTON5-TEXT = '반려'.
    LS_BUTTON5-BUTN_TYPE = 0.
    LS_BUTTON5-ICON = ICON_LED_YELLOW.
    LS_BUTTON5-QUICKINFO = 'FILTER'.


    APPEND LS_BUTTON5 TO E_OBJECT-&gt;MT_TOOLBAR.
  ENDMETHOD.

  "전체조회 버튼 CREATE
  METHOD ON_TOOLBAR4.
    DATA: LS_BUTTON4 TYPE STB_BUTTON.
    LS_BUTTON4-BUTN_TYPE = 3.
    APPEND LS_BUTTON4 TO E_OBJECT-&gt;MT_TOOLBAR.

    CLEAR: LS_BUTTON4.
    LS_BUTTON4-FUNCTION = 'ALL_SEARCH'.
    LS_BUTTON4-TEXT = '전체조회'.
    LS_BUTTON4-BUTN_TYPE = 0.
    LS_BUTTON4-ICON = ICON_SYSTEM_REDO.
    LS_BUTTON4-QUICKINFO = 'SEARCH'.

    APPEND LS_BUTTON4 TO E_OBJECT-&gt;MT_TOOLBAR.
  ENDMETHOD.

  "핫스팟으로 클릭한 사원 ID
  METHOD ON_HOTSPOT_CLICK.

    READ TABLE GT_ZTBMM0010 INTO GS_ZTBMM0010 INDEX ES_ROW_NO-ROW_ID.

    IF E_COLUMN_ID-FIELDNAME = 'REJID'.
      GV_EMPID = GS_ZTBMM0010-REJID.

      " REJID가 빈 값인지 확인
      IF NOT GV_EMPID IS INITIAL.
        CALL SCREEN 130
          STARTING AT 5 5.
      ELSE.
<font color ="#0000FF">*      MESSAGE '해당 필드의 값이 없습니다.' TYPE 'I'.</font>
      ENDIF.
    ENDIF.


  ENDMETHOD.


ENDCLASS.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
