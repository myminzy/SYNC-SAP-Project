<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>MZBMM0020_F01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: MZBMM0020_F01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include MZBMM0020_F01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          MZBMM0020_F01</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_LAYOUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_LAYOUT .

  GS_LAYOUT-ZEBRA = 'X'.      "ALV 행 색상
  GS_LAYOUT-CWIDTH_OPT = 'A'. "필드 가로길이 자동설정
  GS_LAYOUT-GRID_TITLE = '인포레코드ALV 화면'. "ALV 타이틀 설정
  GS_LAYOUT-SEL_MODE = 'B'.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_FCAT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_FCAT .

  GS_FCAT-FIELDNAME = 'DELFLG'.
  GS_FCAT-NO_OUT = 'X'.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR : GS_FCAT.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_GET_DATA_0100</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_GET_DATA_0100 .

  "인포레코드 번호
<font color ="#0000FF">*  SELECT-OPTIONS TABLE CREATE</font>
  IF ZTBMM0070-INFNUM IS NOT INITIAL.
    RS_INFNUM-SIGN = 'I'.
    RS_INFNUM-OPTION = 'EQ'.
    RS_INFNUM-LOW = ZTBMM0070-INFNUM.
    APPEND RS_INFNUM TO RT_INFNUM.
  ENDIF.

  " 거래처 코드
  IF ZTBMM0070-BPCODE IS NOT INITIAL.
    RS_BPCODE-SIGN = 'I'.
    RS_BPCODE-OPTION = 'EQ'.
    RS_BPCODE-LOW = ZTBMM0070-BPCODE.
    APPEND RS_BPCODE TO RT_BPCODE.
  ENDIF.

  "계약시작일
  IF ZTBMM0070-DATSR IS NOT INITIAL.
    RS_DATSR-SIGN  = 'I'.
    RS_DATSR-OPTION = 'EQ'.
    RS_DATSR-LOW = ZTBMM0070-DATSR.
    APPEND RS_DATSR TO RT_DATSR.
  ENDIF.

  "계약종료일
  IF ZTBMM0070-DATEN IS NOT INITIAL.
    RS_DATEN-SIGN = 'I'.
    RS_DATEN-OPTION = 'EQ'.
    RS_DATEN-LOW = ZTBMM0070-DATEN.
    APPEND RS_DATEN TO RT_DATEN.
  ENDIF.

  "GET DATA
  SELECT *
    FROM ZTBMM0070
    INTO CORRESPONDING FIELDS OF TABLE GT_ZTBMM0070
    WHERE INFNUM IN RT_INFNUM
    AND BPCODE IN RT_BPCODE
    AND DATSR IN  RT_DATSR
    AND DATEN IN  RT_DATEN.

  "BP MASTER GET DATA

  IF ZTBSD1050-BPCODE IS NOT INITIAL.
    RS_BPCODE_SD-SIGN = 'I'.
    RS_BPCODE_SD-OPTION = 'EQ'.
    RS_BPCODE_SD-LOW = ZTBSD1050-BPCODE.
    APPEND RS_BPCODE_SD TO RT_BPCODE_SD.
  ENDIF.

  SELECT *
    FROM ZTBSD1050
    INTO TABLE GT_ZTBSD1050
    WHERE BPCODE IN RT_BPCODE_SD.
<font color ="#0000FF">*  IF ZTBSD1050-BPTCODE IS NOT INITIAL.</font>
<font color ="#0000FF">*    RS_BPNUM-SIGN = 'I'.</font>
<font color ="#0000FF">*    RS_BPNUM-OPTION = 'EQ'.</font>
<font color ="#0000FF">*    RS_BPNUM-LOW = ZTBSD1050-BPCODE.</font>
<font color ="#0000FF">*    APPEND RS_BPNUM_SD TO RT_BPNUM.</font>
<font color ="#0000FF">*  ENDIF.</font>



ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_MODIFY</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_MODIFY .

  CALL METHOD GO_ALV-&gt;GET_SELECTED_ROWS
    IMPORTING
      ET_INDEX_ROWS = ET_INDEX_ROW.

  IF ET_INDEX_ROW IS INITIAL.
    MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '008' DISPLAY LIKE 'E'. "행을 먼저 선택해주세요!

  ELSE.

    READ TABLE ET_INDEX_ROW INTO ES_INDEX_ROW INDEX 1.

    SEL_IDX = ES_INDEX_ROW-INDEX.

    READ TABLE GT_ZTBMM0070 INTO GS_ZTBMM0070 INDEX SEL_IDX.

    "MODIFY
    IF OK_CODE = 'MODIFY'.
      CALL SCREEN 120
      STARTING AT 5 5.
    ENDIF.


  ENDIF.



ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_MODIFY_SAVE</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_MODIFY_SAVE .

  DATA : LS_ANSWER TYPE C.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      TITLEBAR              = '인포레코드 데이터 수정'
      TEXT_QUESTION         = '인포레코드 데이터를 수정하시겠습니까?'
      TEXT_BUTTON_1         = 'YES'
      ICON_BUTTON_1         = 'ICON_OKAY'
      TEXT_BUTTON_2         = 'NO'
      ICON_BUTTON_2         = 'ICON_CANCEL'
      DISPLAY_CANCEL_BUTTON = ''
    IMPORTING
      ANSWER                = LS_ANSWER
    EXCEPTIONS
      TEXT_NOT_FOUND        = 1
      OTHERS                = 2.
  IF SY-SUBRC &lt;&gt; 0.
  ENDIF.

  IF LS_ANSWER = 1.

    GS_ZTBMM0070-INFQUANT = ZTBMM0070-INFQUANT.  "구매단위 수량
    GS_ZTBMM0070-UNITCODE = ZTBMM0070-UNITCODE.  "단위
    GS_ZTBMM0070-INFPRICE = ZTBMM0070-INFPRICE.  "구매단위 당 단가
    GS_ZTBMM0070-CURRENCY = ZTBMM0070-CURRENCY.   "화폐단위
    GS_ZTBMM0070-ZTERM = ZTBMM0070-ZTERM.         " 지급조건
    GS_ZTBMM0070-DATSR = ZTBMM0070-DATSR.         "계약시작일
    GS_ZTBMM0070-DATEN = ZTBMM0070-DATEN.         "계약종료일


    UPDATE ZTBMM0070 FROM GS_ZTBMM0070.

    IF SY-SUBRC = 0.

      MODIFY GT_ZTBMM0070 FROM GS_ZTBMM0070 INDEX SEL_IDX.
      MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '011'.      " 수정 성공했다고 메세지 출력
    ELSE.
      MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '012'.  " 실패했다고 메세지 출력
    ENDIF.

    CLEAR: ZTBMM0070.

  ENDIF.



ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_CREATE_SAVE</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_CREATE_SAVE .

  DATA : LS_ANSWER TYPE C.


  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      TITLEBAR              = '인포레코드 데이터 생성'
      TEXT_QUESTION         = '인포레코드 데이터를 생성하시겠습니까?'
      TEXT_BUTTON_1         = 'YES'
      ICON_BUTTON_1         = 'ICON_OKAY'
      TEXT_BUTTON_2         = 'NO'
      ICON_BUTTON_2         = 'ICON_CANCEL'
      DISPLAY_CANCEL_BUTTON = ''
    IMPORTING
      ANSWER                = LS_ANSWER
    EXCEPTIONS
      TEXT_NOT_FOUND        = 1
      OTHERS                = 2.
  IF SY-SUBRC &lt;&gt; 0.
  ENDIF.

  IF LS_ANSWER = 1.
<font color ="#0000FF">*    LOOP AT GT_ZTBMM0070 INTO GS_ZTBMM0070.</font>


    DATA: LS_NR TYPE N LENGTH 9.

    GS_ZTBMM0070-MATCODE = MATCODE110.  "자재번호
    GS_ZTBMM0070-BPCODE = BPCODE110.  "거래처 코드
    GS_ZTBMM0070-INFQUANT = INFQUANT110.  "구매단위 수량
    GS_ZTBMM0070-UNITCODE = UNITCODE110.  "단위
    GS_ZTBMM0070-INFPRICE = INFPRICE110.  "구매단위 당 단가
    GS_ZTBMM0070-CURRENCY = CURRENCY110.   "화폐단위
    GS_ZTBMM0070-LDTIME = LDTIME110.
    GS_ZTBMM0070-ZTERM = ZTERM110.         " 지급조건
    GS_ZTBMM0070-DATSR = DATSR110.         "계약시작일
    GS_ZTBMM0070-DATEN = DATEN110.         "계약종료일


    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        NR_RANGE_NR             = '01'            " NUMBER RANGE의 인터벌 번호
        OBJECT                  = 'ZBBMM0070'    "생성한 NUMBER RANGE OBJECT 이름
<font color ="#0000FF">*       QUANTITY                = '1'</font>
<font color ="#0000FF">*       SUBOBJECT               = ' '</font>
<font color ="#0000FF">*       TOYEAR                  = '0000'</font>
<font color ="#0000FF">*       IGNORE_BUFFER           = ' '</font>
      IMPORTING
        NUMBER                  = LS_NR              " 생성한 번호 받아오는 변수 넣어주기
<font color ="#0000FF">*       QUANTITY                =</font>
<font color ="#0000FF">*       RETURNCODE              =</font>
      EXCEPTIONS
        INTERVAL_NOT_FOUND      = 1
        NUMBER_RANGE_NOT_INTERN = 2
        OBJECT_NOT_FOUND        = 3
        QUANTITY_IS_0           = 4
        QUANTITY_IS_NOT_1       = 5
        INTERVAL_OVERFLOW       = 6
        BUFFER_OVERFLOW         = 7
        OTHERS                  = 8.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

    GS_ZTBMM0070-INFNUM = 'INF' && LS_NR.

    INSERT ZTBMM0070 FROM GS_ZTBMM0070.

<font color ="#0000FF">*    MOVE-CORRESPONDING GS_ZTBMM0070 TO GT_ZTBMM0070.</font>

    IF SY-SUBRC = 0.
      MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '001'.       " 수정 성공 메세지 출력
<font color ="#0000FF">*      MODIFY ZTBMM0070 FROM TABLE GT_ZTBMM0070.</font>
      APPEND GS_ZTBMM0070 TO GT_ZTBMM0070.
    ELSE.
      MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '010'.       " 생성 실패했다고 메세지 출력
    ENDIF.

    CLEAR: ZTBMM0070-BPCODE,ZTBMM0070-MATCODE, ZTBSD1051-BPNAME, ZTBMM0070-INFQUANT ,ZTBMM0070-UNITCODE,ZTBMM0070-INFPRICE,ZTBMM0070-CURRENCY, ZTBMM0070-ZTERM ,ZTBMM0070-DATSR ,ZTBMM0070-DATEN.
    " ALV REFRESH -&gt; 변경 사항 적용해서 화면에 보여주기 위함
    CALL METHOD GO_ALV-&gt;REFRESH_TABLE_DISPLAY
      EXCEPTIONS
        FINISHED = 1
        OTHERS   = 2.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.


  ENDIF.


ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_REFRESH</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_REFRESH .

<font color ="#0000FF">* ALV REFRESH -&gt; 변경 사항 적용해서 화면에 보여주기 위함</font>
    CALL METHOD GO_ALV-&gt;REFRESH_TABLE_DISPLAY
      EXCEPTIONS
        FINISHED = 1
        OTHERS   = 2.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.
ENDFORM.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
