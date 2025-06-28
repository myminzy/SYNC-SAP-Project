<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBRMM0030_F01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBRMM0030_F01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include ZBRMM0030_F01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          ZBRMM0030_F01</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_ALV1</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_ALV1 .

  PERFORM ZBMM_SET_LAYOUT1.
  PERFORM ZBMM_SET_FCAT1.

  CALL METHOD GO_ALV1-&gt;SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      I_STRUCTURE_NAME              = 'ZSBMM0020_ALV1'
      IS_LAYOUT                     = LS_LAYOUT1
    CHANGING
      IT_OUTTAB                     = GT_ZTBMM0010
      IT_FIELDCATALOG               = LT_FCAT1
<font color ="#0000FF">*     IT_SORT                       =</font>
<font color ="#0000FF">*     IT_FILTER                     =</font>
    EXCEPTIONS
      INVALID_PARAMETER_COMBINATION = 1
      PROGRAM_ERROR                 = 2
      TOO_MANY_LINES                = 3
      OTHERS                        = 4.
  IF SY-SUBRC &lt;&gt; 0.
  ENDIF.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_LAYOUT1</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_LAYOUT1 .

  LS_LAYOUT1-ZEBRA = 'X'.
  LS_LAYOUT1-CWIDTH_OPT = 'A'.
  LS_LAYOUT1-GRID_TITLE = '구매오더 미완료 ALV 화면'. "ALV 타이틀 설정
  LS_LAYOUT1-EXCP_FNAME = 'LIGHT'.   "신호등
<font color ="#0000FF">*  LS_LAYOUT1-EXCP_LED = 'X'.          "하나짜리 신호등으로 변경</font>
  LS_LAYOUT1-SEL_MODE = 'A'.

<font color ="#0000FF">*  'A','B': 행 하나만 선택 가능, 드레그 불가S</font>
<font color ="#0000FF">*  'C': 행 하나만 선택 가능, 드레그 가능</font>
<font color ="#0000FF">*  'D': 복수 가능, 드레그 원하는 형태로 가능</font>

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_ALV2</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_ALV2 .

  PERFORM ZBMM_SET_LAYOUT2.
  PERFORM ZBMM_SET_FCAT2.

  CALL METHOD GO_ALV2-&gt;SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_LAYOUT                     = LS_LAYOUT2
      I_STRUCTURE_NAME              = 'ZSBMM0020_PO'
    CHANGING
      IT_OUTTAB                     = GT_ZTBMM0020
      IT_FIELDCATALOG               = LT_FCAT2
<font color ="#0000FF">*     IT_SORT                       =</font>
<font color ="#0000FF">*     IT_FILTER                     =</font>
    EXCEPTIONS
      INVALID_PARAMETER_COMBINATION = 1
      PROGRAM_ERROR                 = 2
      TOO_MANY_LINES                = 3
      OTHERS                        = 4.
  IF SY-SUBRC &lt;&gt; 0.
  ENDIF.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_ALV_DATA</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_ALV_DATA .

<font color ="#0000FF">*  *PR_NUM SO_DAT</font>
<font color ="#0000FF">*  ZSBMM0020_ALV1   -&gt;  구매요청 헤더 & 아이템 모든 필드</font>
<font color ="#0000FF">*  ZSBMM0020_PO     -&gt; 구매오더 헤더 & 아이템 모든 필드</font>

  SELECT *
    FROM ZTBMM0010 AS A
    "1: N
    LEFT JOIN ZTBMM0011 AS B
    ON A~PRNUM EQ B~PRNUM
<font color ="#0000FF">*    WHERE A~PRNUM EQ @PR_NUM AND A~PRDATE IN @SO_DAT</font>
    WHERE A~PRNUM IN @PR_NUM AND A~PRDATE IN @SO_DAT
    AND A~STATUS EQ 'A' AND A~PONUM_STATUS EQ 'X'
    ORDER BY A~PRNUM ASCENDING
    INTO CORRESPONDING FIELDS OF TABLE @GT_ZTBMM0010.

  "신호등 CREATE
  PERFORM ZBMM_GET_LIGHT.

  IF SY-SUBRC &lt;&gt; 0.  "조건에 일치하는 데이터가 없는 경우 메세지 출력
    MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '015' DISPLAY LIKE 'E'.
  ENDIF.


ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_LAYOUT2</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_LAYOUT2 .

  LS_LAYOUT2-ZEBRA = 'X'.
  LS_LAYOUT2-CWIDTH_OPT = 'A'.
  LS_LAYOUT2-GRID_TITLE = '구매오더 완료 ALV 화면'. "ALV 타이틀 설정
  LS_LAYOUT2-SEL_MODE = 'A'.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_FCAT1</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_FCAT1 .

  "신호등 표시
  LS_FCAT1-FIELDNAME = 'LIGHT'.
  LS_FCAT1-COLTEXT = '구매오더여부'.
  LS_FCAT1-COL_POS = 0.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  "반려사유 필드 숨기기
  LS_FCAT1-FIELDNAME = 'PRNGT'.
  LS_FCAT1-NO_OUT = 'X'.
  APPEND LS_FCAT1 TO LT_FCAT1.

  "STATUS 숨기기 구매요청상태 숨기기
  LS_FCAT1-FIELDNAME = 'STATUS'.
  LS_FCAT1-NO_OUT = 'X'.
  APPEND LS_FCAT1 TO LT_FCAT1.

  "PONUM_STATUS 구매오더상태 숨기기
  LS_FCAT1-FIELDNAME = 'PONUM_STATUS'.
  LS_FCAT1-NO_OUT = 'X'.
  APPEND LS_FCAT1 TO LT_FCAT1.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SELL_DATA</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SAVE_DATA .

  DATA: LS_ZTBMM0020 TYPE ZTBMM0020,
        LS_ZTBMM0021 TYPE ZTBMM0021.

  DATA: LS_ZTBMM0010 TYPE ZTBMM0010, "구매요청 헤더
        LS_ZTBMM0011 TYPE ZTBMM0011. "구매요청 아이템


  DATA : LV_ANSWER TYPE C.
  DATA : LS_NR     TYPE NUM8,
         LV_BPCODE TYPE C LENGTH 10,
         LV_PRNUM  TYPE C LENGTH 10,
         LV_PONR   TYPE NUM8.

<font color ="#0000FF">*    생성 컨펌 팝업 띄우기 -&gt; LV_ANSWER에 YES를 선택했는지 NO를 선택했는지에 대한 값이 저장됨</font>
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      TITLEBAR              = '구매오더 생성'
      TEXT_QUESTION         = '구매오더를 생성하시겠습니까?'
      TEXT_BUTTON_1         = 'YES'
      ICON_BUTTON_1         = 'ICON_OKAY'
      TEXT_BUTTON_2         = 'NO'
      ICON_BUTTON_2         = 'ICON_CANCEL'
      DISPLAY_CANCEL_BUTTON = ''
    IMPORTING
      ANSWER                = LV_ANSWER
    EXCEPTIONS
      TEXT_NOT_FOUND        = 1
      OTHERS                = 2.
  IF SY-SUBRC &lt;&gt; 0.
  ENDIF.

  "YES 구매오더 생성
  IF LV_ANSWER = 1.

    "ALV21 -&gt; AVL2 필드 MOVE
    MOVE-CORRESPONDING GT_ZTBMM0010 TO GT_ZTBMM0020.

    "ALV1 UPDATE
    LOOP AT GT_ZTBMM0010 INTO GS_ZTBMM0010.
      "구매오더 생성 완료 STATUS UPDATE
      GS_ZTBMM0010-PONUM_STATUS = 'A'.
      GS_ZTBMM0010-LIGHT = 3.     "신호등 초록색
      MODIFY GT_ZTBMM0010 FROM GS_ZTBMM0010.
      UPDATE ZTBMM0010 SET PONUM_STATUS = 'A' WHERE PRNUM = GS_ZTBMM0010-PRNUM.
    ENDLOOP.

    "ALV1 -&gt; AVL2 필드 MOVE
    MOVE-CORRESPONDING GT_ZTBMM0010 TO GT_ZTBMM0020.

    "ALV2
    LOOP AT GT_ZTBMM0020 INTO GS_ZTBMM0020.

      READ TABLE GT_ZTBMM0010 INTO GS_ZTBMM0010 INDEX SY-TABIX.

      "NUMBER RANGE
      IF GS_ZTBMM0010-PRNUM &lt;&gt; LV_PRNUM.

        LV_PRNUM = GS_ZTBMM0010-PRNUM.

        CALL FUNCTION 'NUMBER_GET_NEXT'
          EXPORTING
            NR_RANGE_NR             = '01'
            OBJECT                  = 'ZBBMM0010'
          IMPORTING
            NUMBER                  = LV_PONR
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

        CONCATENATE 'PO' LV_PONR INTO GS_ZTBMM0020-PONUM.

      ELSE. " 이전 행의 BPCODE와 현재행의 BPCODE 값이 같을 때.
        CONCATENATE 'PO' LV_PONR INTO GS_ZTBMM0020-PONUM.
      ENDIF.

      IF SY-SUBRC = 0.
        "구매오더 번호, 구매오더 생성일, 입고예정일 추가
<font color ="#0000FF">*        GS_ZTBMM0020-PONUM = 'PO' && LS_NR. "NUMBER RANGE 생성</font>
        GS_ZTBMM0020-PODATE = SY-DATUM.     "날짜생성

        GS_ZTBMM0020-POQUANT = GS_ZTBMM0010-PRQUANT. "구매요청 수량 = 구매오더 수량
        GS_ZTBMM0020-POPRICE = GS_ZTBMM0010-PRPRICE. "요청금액 -&gt; 구매오더 금액
      ENDIF.


      "입고예정일
      SELECT SINGLE LDTIME
        FROM ZTBMM0070
       WHERE MATCODE EQ @GS_ZTBMM0020-MATCODE
        INTO @DATA(LV_LDTIME).

      GS_ZTBMM0020-EINDT = LV_LDTIME + SY-DATUM.
      GS_ZTBMM0020-STATUS = 'A'.         "구매오더 생성 후 구매요청에서 -&gt; 입고대기상태로 업데이트
      GS_ZTBMM0020-STATUS2 = 'A'.         "송장 등록여부 A 상태 업데이트


      "구매오더 HEADE4R
      MOVE-CORRESPONDING GS_ZTBMM0020 TO LS_ZTBMM0020.
      INSERT ZTBMM0020 FROM LS_ZTBMM0020.

      IF SY-SUBRC = 0.
        MODIFY GT_ZTBMM0020 FROM GS_ZTBMM0020.
      ENDIF.

      "구매오더 ITEM
      MOVE-CORRESPONDING GS_ZTBMM0020 TO LS_ZTBMM0021.
      INSERT ZTBMM0021 FROM LS_ZTBMM0021.

      IF SY-SUBRC = 0.
        MODIFY GT_ZTBMM0020 FROM GS_ZTBMM0020.
      ENDIF.

    ENDLOOP.

  ENDIF.


  " ALV REFRESH -&gt; 변경 사항 적용해서 화면에 보여주기 위함
  CALL METHOD GO_ALV1-&gt;REFRESH_TABLE_DISPLAY
    EXCEPTIONS
      FINISHED = 1
      OTHERS   = 2.
  IF SY-SUBRC &lt;&gt; 0.
  ENDIF.

  " ALV REFRESH -&gt; 변경 사항 적용해서 화면에 보여주기 위함
  CALL METHOD GO_ALV2-&gt;REFRESH_TABLE_DISPLAY
    EXCEPTIONS
      FINISHED = 1
      OTHERS   = 2.
  IF SY-SUBRC &lt;&gt; 0.
  ENDIF.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_GET_LIGHT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      --&gt; GT_ZTBMM0020</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*FORM ZBMM_GET_LIGHT_200.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*  LOOP AT GT_ZTBMM0020 INTO GS_ZTBMM0020.</font>
<font color ="#0000FF">*    IF GS_ZTBMM0020-STATUS = 'A'.      " 입고 대기</font>
<font color ="#0000FF">*      GS_ZTBMM0020-LIGHT = 1.         " 신호등 빨강색</font>
<font color ="#0000FF">*    ELSEIF GS_ZTBMM0020-STATUS = 'B'.  " 입고 완료</font>
<font color ="#0000FF">*      GS_ZTBMM0020-LIGHT = 2.     "신호등 노랑색</font>
<font color ="#0000FF">*    ELSE.</font>
<font color ="#0000FF">*      GS_ZTBMM0020-STATUS = 'C'.       "송장검증완료</font>
<font color ="#0000FF">*      GS_ZTBMM0020-LIGHT = 3.</font>
<font color ="#0000FF">*    ENDIF.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    MODIFY GT_ZTBMM0020 FROM GS_ZTBMM0020.</font>
<font color ="#0000FF">*  ENDLOOP.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*ENDFORM.</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_GET_LIGHT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_GET_LIGHT .

  LOOP AT GT_ZTBMM0010 INTO GS_ZTBMM0010.
    IF GS_ZTBMM0010-PONUM_STATUS = 'X'.     " 구매오더 미완료
      GS_ZTBMM0010-LIGHT = 1.               " 신호등 빨강색
      MODIFY GT_ZTBMM0010 FROM GS_ZTBMM0010.
    ENDIF.
  ENDLOOP.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_FCAT2</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_FCAT2 .

  "STATUS 숨기기 구매요청상태 숨기기
  LS_FCAT2-FIELDNAME = 'STATUS'.
  LS_FCAT2-NO_OUT = 'X'.
  APPEND LS_FCAT2 TO LT_FCAT2.

ENDFORM.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
