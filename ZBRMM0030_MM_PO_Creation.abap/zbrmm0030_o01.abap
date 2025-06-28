<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBRMM0030_O01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBRMM0030_O01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include ZBRMM0030_O01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          ZBRMM0030_O01</font>
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
<font color ="#0000FF">*& Module OK_CODE_100 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE OK_CODE_100 OUTPUT.
  CLEAR: OK_CODE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module SET_ALV OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE SET_ALV OUTPUT.

  IF GO_DOCK IS INITIAL.
    "도킹 컨테이너 생성
    CREATE OBJECT GO_DOCK
      EXPORTING
        REPID                       = SY-REPID
        DYNNR                       = SY-DYNNR
        SIDE                        = GO_DOCK-&gt;DOCK_AT_TOP
        EXTENSION                   = 2000
      EXCEPTIONS
        CNTL_ERROR                  = 1
        CNTL_SYSTEM_ERROR           = 2
        CREATE_ERROR                = 3
        LIFETIME_ERROR              = 4
        LIFETIME_DYNPRO_DYNPRO_LINK = 5
        OTHERS                      = 6.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

    "SPLIT으로 화면 분할.
    CREATE OBJECT GO_SPLIT
      EXPORTING
        ROWS    = 2
        COLUMNS = 1
        PARENT  = GO_DOCK.

    "SPLIT 화면에 컨테이너 올리기
    CALL METHOD GO_SPLIT-&gt;GET_CONTAINER
      EXPORTING
        ROW       = 1
        COLUMN    = 1
      RECEIVING
        CONTAINER = GO_TOP.

    CALL METHOD GO_SPLIT-&gt;GET_CONTAINER
      EXPORTING
        ROW       = 2
        COLUMN    = 1
      RECEIVING
        CONTAINER = GO_BOT.

    "스플릿 화면 크기 조정.
    CALL METHOD GO_SPLIT-&gt;SET_ROW_HEIGHT
      EXPORTING
        ID         = 1
        HEIGHT     = 50
      EXCEPTIONS
        CNTL_ERROR = 1.

    "분활된 도킹 컨테이너에 각각 ALV 올림
    CREATE OBJECT GO_ALV1
      EXPORTING
        I_PARENT = GO_TOP.

    CREATE OBJECT GO_ALV2
      EXPORTING
        I_PARENT = GO_BOT.

<font color ="#0000FF">*    SET HANDLER LCL_EVENT_HANDLER=&gt;ON_TOOLBAR1 FOR GO_ALV1. "ITEM 조회 버튼</font>
<font color ="#0000FF">*    SET HANDLER LCL_EVENT_HANDLER=&gt;ON_USER_COMMAND1 FOR GO_ALV1.</font>

    PERFORM ZBMM_SET_ALV1.
    PERFORM ZBMM_SET_ALV2.

  ELSE.


  ENDIF.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module STATUS_0200 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE STATUS_0200 OUTPUT.
  SET PF-STATUS 'S200'.
  SET TITLEBAR 'T200'.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module SET_ALV_0200 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE SET_ALV_0200 OUTPUT.

  IF GO_DOCK200 IS INITIAL.
    CREATE OBJECT GO_DOCK200
      EXPORTING
        REPID                       = SY-REPID
        DYNNR                       = SY-DYNNR
        SIDE                        = GO_DOCK200-&gt;DOCK_AT_TOP
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

    CREATE OBJECT GO_ALV200
      EXPORTING
        I_PARENT = GO_DOCK200.

    PERFORM ZBMM_SET_LAYOUT1.
    PERFORM ZBMM_SET_FCAT1.

    CALL METHOD GO_ALV200-&gt;SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
        I_STRUCTURE_NAME              = 'ZTBMM0020'
        IS_LAYOUT                     = LS_LAYOUT1
      CHANGING
        IT_OUTTAB                     = GT_ZTBMM0020
        IT_FIELDCATALOG               = LT_FCAT1
<font color ="#0000FF">*       IT_SORT                       =</font>
<font color ="#0000FF">*       IT_FILTER                     =</font>
      EXCEPTIONS
        INVALID_PARAMETER_COMBINATION = 1
        PROGRAM_ERROR                 = 2
        TOO_MANY_LINES                = 3
        OTHERS                        = 4.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

  ENDIF.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module GET_DATA_0200 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*MODULE GET_DATA_0200 OUTPUT.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*  "구매요청 헤더 승인된건 가져오기</font>
<font color ="#0000FF">*    SELECT *</font>
<font color ="#0000FF">*      FROM ZTBMM0020</font>
<font color ="#0000FF">*      INTO TABLE GT_ZTBMM0020.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*  "승인된 구미요청이라면</font>
<font color ="#0000FF">*  IF GS_ZTBMM0010-STATUS EQ 'A'.</font>
<font color ="#0000FF">*    "신호등 UPDATE</font>
<font color ="#0000FF">**       IF GS_ZTBMM0020-STATUS EQ ''.</font>
<font color ="#0000FF">*    GS_ZTBMM0020-STATUS = 'A'.</font>
<font color ="#0000FF">*    GS_ZTBMM0020-LIGHT = 1.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    "신호등 CREATE</font>
<font color ="#0000FF">*    PERFORM ZBMM_GET_LIGHT_200.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    "구매오더번호 NUMBER RANGE 생성</font>
<font color ="#0000FF">*    DATA: LS_NR TYPE N LENGTH 8.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    CALL FUNCTION 'NUMBER_GET_NEXT'</font>
<font color ="#0000FF">*      EXPORTING</font>
<font color ="#0000FF">*        NR_RANGE_NR             = '01'</font>
<font color ="#0000FF">*        OBJECT                  = 'ZBBMM0020'</font>
<font color ="#0000FF">*      IMPORTING</font>
<font color ="#0000FF">*        NUMBER                  = LS_NR</font>
<font color ="#0000FF">*      EXCEPTIONS</font>
<font color ="#0000FF">*        INTERVAL_NOT_FOUND      = 1</font>
<font color ="#0000FF">*        NUMBER_RANGE_NOT_INTERN = 2</font>
<font color ="#0000FF">*        OBJECT_NOT_FOUND        = 3</font>
<font color ="#0000FF">*        QUANTITY_IS_0           = 4</font>
<font color ="#0000FF">*        QUANTITY_IS_NOT_1       = 5</font>
<font color ="#0000FF">*        INTERVAL_OVERFLOW       = 6</font>
<font color ="#0000FF">*        BUFFER_OVERFLOW         = 7</font>
<font color ="#0000FF">*        OTHERS                  = 8.</font>
<font color ="#0000FF">*    IF SY-SUBRC &lt;&gt; 0.</font>
<font color ="#0000FF">*    ENDIF.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    GS_ZTBMM0020-PONUM = 'PO' && LS_NR.</font>
<font color ="#0000FF">**        GS_ZTBMM0020_200-PONUM = 'PO' && LS_NR.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">**    MOVE-CORRESPONDING GS_ZTBMM0010 TO GS_ZTBMM0020.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    "DB</font>
<font color ="#0000FF">*    MODIFY ZTBMM0020 FROM GS_ZTBMM0020.</font>
<font color ="#0000FF">*    IF SY-SUBRC &lt;&gt; 0.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    ENDIF.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    IF SY-SUBRC = 0.</font>
<font color ="#0000FF">*      MODIFY GT_ZTBMM0020 FROM GS_ZTBMM0020 INDEX SEL_IDX.</font>
<font color ="#0000FF">*      " MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '011'.     " 수정 성공했다고 메세지 출력</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">**                ELSE.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    ENDIF.</font>
<font color ="#0000FF">**       ENDIF.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">**        "구매오더번호 NUMBER RANGE 생성</font>
<font color ="#0000FF">**        DATA: LS_NR TYPE N LENGTH 8.</font>
<font color ="#0000FF">**</font>
<font color ="#0000FF">**        CALL FUNCTION 'NUMBER_GET_NEXT'</font>
<font color ="#0000FF">**          EXPORTING</font>
<font color ="#0000FF">**            NR_RANGE_NR             =  '01'</font>
<font color ="#0000FF">**            OBJECT                  =  'ZBBMM0020'</font>
<font color ="#0000FF">**          IMPORTING</font>
<font color ="#0000FF">**            NUMBER                  =  LS_NR</font>
<font color ="#0000FF">**          EXCEPTIONS</font>
<font color ="#0000FF">**            INTERVAL_NOT_FOUND      = 1</font>
<font color ="#0000FF">**            NUMBER_RANGE_NOT_INTERN = 2</font>
<font color ="#0000FF">**            OBJECT_NOT_FOUND        = 3</font>
<font color ="#0000FF">**            QUANTITY_IS_0           = 4</font>
<font color ="#0000FF">**            QUANTITY_IS_NOT_1       = 5</font>
<font color ="#0000FF">**            INTERVAL_OVERFLOW       = 6</font>
<font color ="#0000FF">**            BUFFER_OVERFLOW         = 7</font>
<font color ="#0000FF">**            OTHERS                  = 8</font>
<font color ="#0000FF">**          .</font>
<font color ="#0000FF">**        IF SY-SUBRC &lt;&gt; 0.</font>
<font color ="#0000FF">**        ENDIF.</font>
<font color ="#0000FF">**</font>
<font color ="#0000FF">**        GS_ZTBMM0020-PONUM = 'PO' && LS_NR.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    "DB 테이블이 스트럭쳐 UPDATE</font>
<font color ="#0000FF">**       INSERT GS_ZTBMM0020 INTO GT_ZTBMM0020.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">**        IF SY-SUBRC = 0.</font>
<font color ="#0000FF">**            MODIFY GT_ZTBMM0020_200 FROM GS_ZTBMM0020_200.</font>
<font color ="#0000FF">**           ELSE.</font>
<font color ="#0000FF">**        ENDIF.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">**        LOOP AT GT_ZTBMM0020 INTO GS_ZTBMM0020.</font>
<font color ="#0000FF">**          READ TABLE GT_ZTBMM0020 INTO GS_ZTBMM0020 INDEX SEL_IDX.</font>
<font color ="#0000FF">**</font>
<font color ="#0000FF">**          IF SY-SUBRC = 0.</font>
<font color ="#0000FF">**            INSERT GS_ZTBMM0020 INTO GT_ZTBMM0020.</font>
<font color ="#0000FF">**          ENDIF.</font>
<font color ="#0000FF">**</font>
<font color ="#0000FF">**        ENDLOOP.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">**         CALL METHOD GO_ALV200-&gt;REFRESH_TABLE_DISPLAY</font>
<font color ="#0000FF">**           EXCEPTIONS</font>
<font color ="#0000FF">**             FINISHED       = 1</font>
<font color ="#0000FF">**             OTHERS         = 2.</font>
<font color ="#0000FF">**         IF SY-SUBRC &lt;&gt; 0.</font>
<font color ="#0000FF">**         ENDIF.</font>
<font color ="#0000FF">*  ENDIF.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*  "구매오더 헤더 값가져오기</font>
<font color ="#0000FF">*  SELECT *</font>
<font color ="#0000FF">*    FROM ZTBMM0020</font>
<font color ="#0000FF">*    INTO TABLE GT_ZTBMM0020</font>
<font color ="#0000FF">*      WHERE PRNUM = GS_ZTBMM0020-PRNUM.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*  CALL METHOD GO_ALV200-&gt;REFRESH_TABLE_DISPLAY</font>
<font color ="#0000FF">*    EXCEPTIONS</font>
<font color ="#0000FF">*      FINISHED = 1</font>
<font color ="#0000FF">*      OTHERS   = 2.</font>
<font color ="#0000FF">*  IF SY-SUBRC &lt;&gt; 0.</font>
<font color ="#0000FF">*  ENDIF.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*ENDMODULE.</font>
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
