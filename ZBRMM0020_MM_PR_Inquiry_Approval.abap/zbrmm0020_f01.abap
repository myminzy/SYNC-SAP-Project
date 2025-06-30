<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBRMM0020_F01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBRMM0020_F01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include ZBRMM0020_F01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          ZBRMM0020_F01</font>
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

  PERFORM ZBMM_SET_LAYOUT1. "ALV 레이아웃 설정
  PERFORM ZBMM_SET_FCAT1. "FIELDCATALOG 설정
<font color ="#0000FF">*  PERFORM ZBMM_SET_SORT.</font>

  CALL METHOD GO_ALV1-&gt;SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_LAYOUT                     = LS_LAYOUT1
      I_STRUCTURE_NAME              = 'ZTBMM0010'
    CHANGING
      IT_OUTTAB                     = GT_ZTBMM0010
      IT_FIELDCATALOG               = LT_FCAT1
<font color ="#0000FF">*     IT_SORT                       = LT_SORT1</font>
    EXCEPTIONS
      INVALID_PARAMETER_COMBINATION = 1
      PROGRAM_ERROR                 = 2
      TOO_MANY_LINES                = 3
      OTHERS                        = 4.
  IF SY-SUBRC &lt;&gt; 0.
  ENDIF.
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

  PERFORM ZBMM_SET_LAYOUT2. "ALV 레이아웃 설정
  PERFORM ZBMM_SET_FCAT2. "FIELDCATALOG 설정

  CALL METHOD GO_ALV2-&gt;SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_LAYOUT                     = LS_LAYOUT2
      I_STRUCTURE_NAME              = 'ZTBMM0011'
    CHANGING
      IT_OUTTAB                     = GT_ZTBMM0011
      IT_FIELDCATALOG               = LT_FCAT2
    EXCEPTIONS
      INVALID_PARAMETER_COMBINATION = 1
      PROGRAM_ERROR                 = 2
      TOO_MANY_LINES                = 3
      OTHERS                        = 4.
  IF SY-SUBRC &lt;&gt; 0.
  ENDIF.
ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form set_init</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_INIT .

  SO_DAT-SIGN   = 'I'.
  SO_DAT-OPTION = 'BT'.
  SO_DAT-LOW    = SY-DATUM+0(4) && '0101'.
  SO_DAT-HIGH    = SY-DATUM+0(4) && '1231'.
  APPEND SO_DAT.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form GET_DATA100</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_ALL_DATA .

  IF PA_NUM IS NOT INITIAL.     "PA_NUM 파라미터에 값이 들어온 경우
    RS_PRNUM-SIGN = 'I'.
    RS_PRNUM-OPTION = 'EQ'.
    RS_PRNUM-LOW = PA_NUM.       "PA_NUM 파라미터의 값을 RS_PRNUM-LOW에 할당
    APPEND RS_PRNUM TO RT_PRNUM. "RT_PRNUM에 RS_PRNUM 스트럭쳐를 APEND
  ENDIF.

  SELECT *
    FROM ZTBMM0010 AS A         "구매요청 HEADER
    JOIN ZTBSD1051 AS B         "구매요청 ITEM
      ON A~BPCODE EQ B~BPCODE   "거래처 코드
    JOIN ZTBMM1020 AS C         "플랜트 MASTER
      ON A~PLTCODE EQ C~PLTCODE "플랜트 코드
    JOIN ZTBMM1030 AS D         "창고 MASTER
      ON A~WHCODE EQ D~WHCODE   "창고코드
     WHERE A~PRDATE IN @SO_DAT  "날짜조회
     AND A~PRNUM IN @RT_PRNUM   "구매요청번호 조회
      INTO CORRESPONDING FIELDS OF TABLE @GT_ZTBMM0010. "ALV1

  PERFORM ZBMM_GET_LIGHT TABLES GT_ZTBMM0010. "신호등표시(STATUS UPDATE)

  IF SY-SUBRC &lt;&gt; 0.  "조건에 일치하는 데이터가 없는 경우 메세지 출력
    MESSAGE ID 'ZCOMMON_MSG' TYPE 'I' NUMBER '015' .
<font color ="#0000FF">*    LEAVE TO SCREEN 0.</font>
  ENDIF.

  CLEAR: RT_PRNUM, SO_DAT.

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
  LS_LAYOUT1-GRID_TITLE = '구매요청 HEADER ALV 화면'.
  LS_LAYOUT1-EXCP_FNAME = 'LIGHT'.
  LS_LAYOUT1-EXCP_LED = 'X'.
<font color ="#0000FF">*  LS_LAYOUT1-SEL_MODE = 'D'.</font>

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
  LS_LAYOUT2-GRID_TITLE = '구매요청 ITEM ALV 화면'.
  LS_LAYOUT2-SEL_MODE = 'B'.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_FCAT1</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text=</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_FCAT1 .

  "하스팟
  LS_FCAT1-FIELDNAME = 'REJID'.
  LS_FCAT1-HOTSPOT = 'X'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'STATUS'.
  LS_FCAT1-COLTEXT = '구매오더여부'.
  LS_FCAT1-NO_OUT = 'X'. "숨기기
  APPEND LS_FCAT1 TO LT_FCAT1.

  LS_FCAT1-FIELDNAME = 'PONUM_STATUS'.
  LS_FCAT1-COLTEXT = '구매오더여부'.
  LS_FCAT1-NO_OUT = 'X'. "숨기기
  APPEND LS_FCAT1 TO LT_FCAT1.

<font color ="#0000FF">*------ ALV1</font>
  LS_FCAT1-FIELDNAME = 'LIGHT'.
  LS_FCAT1-COLTEXT = '구매오더여부'.
  LS_FCAT1-COL_POS = 0.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'PRNUM'.
  LS_FCAT1-COLTEXT = '구매요청번호'.
  LS_FCAT1-COL_POS = 1.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'BPCODE'.
  LS_FCAT1-COLTEXT = '거래처 코드'.
  LS_FCAT1-COL_POS = 2.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'BPNAME'.
  LS_FCAT1-COLTEXT = '거래처명'.
  LS_FCAT1-COL_POS = 3.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'PLTCODE'.
  LS_FCAT1-COLTEXT = '플랜트 코드'.
  LS_FCAT1-COL_POS = 4.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'PLTNAME'.
  LS_FCAT1-COLTEXT = '플랜트명'.
  LS_FCAT1-COL_POS = 5.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'WHCODE'.
  LS_FCAT1-COLTEXT = '창고코드'.
  LS_FCAT1-COL_POS = 6.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'WHNAME'.
  LS_FCAT1-COLTEXT = '창고명'.
  LS_FCAT1-COL_POS = 7.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'PRDATE'.
  LS_FCAT1-COLTEXT = '구매요청생성일'.
  LS_FCAT1-COL_POS = 8.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'EMPID'.
  LS_FCAT1-COLTEXT = '구매요청생성자'.
  LS_FCAT1-COL_POS = 9.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'REJID'.
  LS_FCAT1-COLTEXT = '결재담당자'.
  LS_FCAT1-COL_POS = 10.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'REJDAT'.
  LS_FCAT1-COLTEXT = '결재일자'.
  LS_FCAT1-COL_POS = 10.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.

  LS_FCAT1-FIELDNAME = 'PRNGT'.
  LS_FCAT1-COLTEXT = '반려사유'.
  LS_FCAT1-COL_POS = 11.
  LS_FCAT1-JUST = 'C'.
  APPEND LS_FCAT1 TO LT_FCAT1.
  CLEAR: LS_FCAT1.



ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_GET_LIGHT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      --&gt; GT_ZTBMM0010</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_GET_LIGHT  TABLES   P_GT_ZTBMM0010 STRUCTURE GS_ZTBMM0010.

  "신호등 설정
  LOOP AT P_GT_ZTBMM0010 INTO GS_ZTBMM0010.
    IF GS_ZTBMM0010-STATUS = 'A'. "승인
      GS_ZTBMM0010-LIGHT = 3.     "신호등 초록색
    ELSEIF
       GS_ZTBMM0010-STATUS = 'X'. "미승인
      GS_ZTBMM0010-LIGHT = 1.     "신호등 빨강색
    ELSE.
      GS_ZTBMM0010-STATUS = 'N'.  "반려
      GS_ZTBMM0010-LIGHT = 2.     "신호등 노랑색
    ENDIF.

    MODIFY P_GT_ZTBMM0010 FROM GS_ZTBMM0010.
  ENDLOOP.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SEL_DATA</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SEL_DATA .

<font color ="#0000FF">*    ALV 행선택</font>
  DATA: ET_INDEX_ROW TYPE LVC_T_ROW,
        ES_INDEX_ROW TYPE LVC_S_ROW.

  CALL METHOD GO_ALV1-&gt;GET_SELECTED_ROWS
    IMPORTING
      ET_INDEX_ROWS = ET_INDEX_ROW.

  IF ET_INDEX_ROW IS NOT INITIAL.

    READ TABLE ET_INDEX_ROW INTO ES_INDEX_ROW INDEX 1.
    SEL_IDX = ES_INDEX_ROW-INDEX.

    READ TABLE GT_ZTBMM0010 INTO GS_ZTBMM0010 INDEX SEL_IDX.

    IF SY-SUBRC = 0.

<font color ="#0000FF">*       "구매요청 결재 창</font>
      CALL  SCREEN 120
      STARTING AT 45 5.

      CLEAR: SEL_IDX, GS_ZTBMM0010, ES_INDEX_ROW , ET_INDEX_ROW.

    ENDIF.

  ELSE.
    "행을 먼저 선택해주세요!
    MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '008' DISPLAY LIKE 'E'.
  ENDIF.


ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_LAYOUT120</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_LAYOUT120 .

  LS_LAYOUT120-ZEBRA = ABAP_ON.
  LS_LAYOUT120-CWIDTH_OPT =  ABAP_ON.
  LS_LAYOUT120-CWIDTH_OPT = 'A'.
  LS_LAYOUT120-SEL_MODE = 'D'.
  LS_LAYOUT120-NO_TOOLBAR = 'X'.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_ORDER_OKAY</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_ORDER_UPDATE .

<font color ="#0000FF">*  IF ZTBMM0010-STATUS = 'X'.</font>

  "LOGID
  SELECT SINGLE EMPID
    FROM ZTBSD1030
    INTO GV_EMPID
    WHERE LOGID = SY-UNAME.

  GS_ZTBMM0010-REJID = GS_ZTBSD1030-EMPID.
  GS_ZTBMM0010-REJDAT = SY-DATUM.


  "신호등 UPDATE
  GS_ZTBMM0010-STATUS = 'N'.
  GS_ZTBMM0010-LIGHT = 2.


  GS_ZTBMM0010-PRNGT = ZTBMM0010-PRNGT.

  UPDATE ZTBMM0010 FROM GS_ZTBMM0010.

  IF SY-SUBRC = 0.
    MODIFY GT_ZTBMM0010 FROM GS_ZTBMM0010 INDEX SEL_IDX.
    "구매요청이 반려 되었습니다.
    MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '041'.
<font color ="#0000FF">*           ELSEIF GS_ZTBMM0010-STATUS = 'A'.</font>
  ELSE.
<font color ="#0000FF">*  " 반려사유가 비어있다면 EXIT</font>
    EXIT.
  ENDIF.


<font color ="#0000FF">*  ENDIF.</font>




ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_ORDER_OKAY</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_ORDER_OKAY .

  "구매요청 승인
  IF  ZTBMM0010-STATUS EQ 'X'.

    "LOGID
    SELECT SINGLE EMPID
      FROM ZTBSD1030
      INTO GV_EMPID
      WHERE LOGID = SY-UNAME.


    GS_ZTBMM0010-REJID = GS_ZTBSD1030-EMPID.
    GS_ZTBMM0010-REJDAT = SY-DATUM.

    "구매요청 상태 변경
    GS_ZTBMM0010-STATUS = 'A'.

    IF  GS_ZTBMM0010-STATUS EQ 'A'.

      GS_ZTBMM0010-PONUM_STATUS = 'X'. "구매오더 미완료 상태
      GS_ZTBMM0010-LIGHT = 3.


      UPDATE ZTBMM0010 FROM GS_ZTBMM0010.

      IF SY-SUBRC = 0.

        MODIFY GT_ZTBMM0010 FROM GS_ZTBMM0010 INDEX SEL_IDX.
        "결재 승인이 완료 되었습니다.
        MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '037'.

      ENDIF.

    ENDIF.

  ENDIF.


ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_CHECK</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_REJECT_CHECK .
  IF ZTBMM0010-STATUS EQ 'A'.
    "구매요청이 완료된건 입니다.
    MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '039' DISPLAY LIKE 'E'.

  ELSEIF ZTBMM0010-STATUS EQ 'N'." 반려된  구매요청 상태값
    " 이미 반려된 구매요청입니다.
    MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '038' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form HANDLE_USER_COMMAND</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      --&gt; E_UCOMM</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_HANDLE_USER_COMMAND  USING    P_E_UCOMM LIKE SY-UCOMM.

  CASE P_E_UCOMM.

      "전체조회 버튼
    WHEN 'ALL_SEARCH'.
      CLEAR: GT_ZTBMM0011, GS_ZTBMM0010.
      PERFORM ZBMM_APPLY_FILTER USING SPACE. "SPACE 공백 NULL 값
      CALL METHOD GO_ALV2-&gt;REFRESH_TABLE_DISPLAY
        EXCEPTIONS
          FINISHED = 1
          OTHERS   = 2.
      IF SY-SUBRC &lt;&gt; 0.
      ENDIF.

      "구매요청완료 버튼
    WHEN 'FILTER1'.
      CLEAR: GT_ZTBMM0011, GS_ZTBMM0010.
      PERFORM ZBMM_APPLY_FILTER USING 'A'.
      CALL METHOD GO_ALV2-&gt;REFRESH_TABLE_DISPLAY
        EXCEPTIONS
          FINISHED = 1
          OTHERS   = 2.
      IF SY-SUBRC &lt;&gt; 0.
      ENDIF.

      "구매요청미완료 버튼
    WHEN 'FILTER2'.
      CLEAR: GT_ZTBMM0011, GS_ZTBMM0010.
      PERFORM ZBMM_APPLY_FILTER USING 'X'.
      CALL METHOD GO_ALV2-&gt;REFRESH_TABLE_DISPLAY
        EXCEPTIONS
          FINISHED = 1
          OTHERS   = 2.
      IF SY-SUBRC &lt;&gt; 0.
      ENDIF.

      "반려버튼
    WHEN 'FILTER4'.
      CLEAR: GT_ZTBMM0011, GS_ZTBMM0010.
      PERFORM ZBMM_APPLY_FILTER USING 'N'.
      CALL METHOD GO_ALV2-&gt;REFRESH_TABLE_DISPLAY
        EXCEPTIONS
          FINISHED = 1
          OTHERS   = 2.
      IF SY-SUBRC &lt;&gt; 0.
      ENDIF.

      "아이템조회 버튼
    WHEN 'IT_SEARCH'.
      CLEAR: GT_ZTBMM0011, GS_ZTBMM0010.
      PERFORM ZBMM_ITEM_SEARCH.


  ENDCASE.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form APPLY_FILTER</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&      --&gt; SPACE</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_APPLY_FILTER  USING    PV_VALUE.

  CLEAR: GT_ZTBMM0011, GS_ZTBMM0010.

  DATA: LT_FILTER TYPE LVC_T_FILT,
        LS_FILTER LIKE LINE OF LT_FILTER.

  IF PV_VALUE IS NOT INITIAL.
    CLEAR: LS_FILTER.
    LS_FILTER-FIELDNAME = 'STATUS'.
    LS_FILTER-SIGN      = 'I'.
    LS_FILTER-OPTION    = 'EQ'.
    LS_FILTER-LOW       = PV_VALUE.
    APPEND LS_FILTER TO LT_FILTER.
  ENDIF.

<font color ="#0000FF">*  필터 기준 설정.</font>
  CALL METHOD GO_ALV1-&gt;SET_FILTER_CRITERIA
    EXPORTING
      IT_FILTER = LT_FILTER.

  CALL METHOD GO_ALV1-&gt;REFRESH_TABLE_DISPLAY.
ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_ODER_CHECK</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_ODER_CHECK .

  IF GS_ZTBMM0010-STATUS EQ 'N'.
    "이미 구매 요청이 반려된 건입니다.
    MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '038' DISPLAY LIKE 'E'.
  ELSEIF GS_ZTBMM0010-STATUS EQ 'A'.
    "이미 구매 요청이 완료된 건입니다.
    MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '039' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_ALV1_REFRESH</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_ALV1_REFRESH .

  GO_ALV1-&gt;REFRESH_TABLE_DISPLAY(
        EXCEPTIONS
          FINISHED       = 1                " Display was Ended (by Export)
          OTHERS         = 2
      ).

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_ITEM_SEARCH</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_ITEM_SEARCH .

  GO_ALV1-&gt;GET_SELECTED_ROWS(
       IMPORTING
        ET_INDEX_ROWS = LT_ROWS_ITEM ).

  READ TABLE LT_ROWS_ITEM INTO LS_ROWS_ITEM INDEX 1.

  IF LS_ROWS_ITEM IS NOT INITIAL.

    READ TABLE GT_ZTBMM0010 INTO GS_ZTBMM0010 INDEX LS_ROWS_ITEM-INDEX.

    SELECT *
      FROM ZTBMM0010 AS A "구매요청 헤더
      JOIN ZTBMM0011 AS B "구매요청 아이템
      ON A~PRNUM EQ B~PRNUM "구매요청번호
      JOIN ZTBMM1011 AS C "자재명
      ON B~MATCODE EQ C~MATCODE "자재번호
      WHERE A~PRNUM EQ @GS_ZTBMM0010-PRNUM "구매요청 번호
       INTO CORRESPONDING FIELDS OF TABLE @GT_ZTBMM0011.

<font color ="#0000FF">*     "ALV2에 DISPLAY</font>
    GO_ALV2-&gt;REFRESH_TABLE_DISPLAY(
       EXCEPTIONS
         FINISHED       = 1
         OTHERS         = 2
     ).

    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

  ELSE.
    "행을 먼저 선택해주세요!
    MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '008' DISPLAY LIKE 'E'.
  ENDIF.

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

  LS_FCAT2-FIELDNAME = 'PRNUM'.
  LS_FCAT2-COLTEXT = '구매요청번호'.
  LS_FCAT2-COL_POS = 1.
  LS_FCAT2-JUST = 'C'.
  APPEND LS_FCAT2 TO LT_FCAT2.
  CLEAR: LS_FCAT2.

  LS_FCAT2-FIELDNAME = 'MATCODE'.
  LS_FCAT2-COLTEXT = '자재번호'.
  LS_FCAT2-COL_POS = 2.
  LS_FCAT2-JUST = 'C'.
  APPEND LS_FCAT2 TO LT_FCAT2.
  CLEAR: LS_FCAT2.

  LS_FCAT2-FIELDNAME = 'MATNAME'.
  LS_FCAT2-COLTEXT = '자재명'.
  LS_FCAT2-COL_POS = 3.
  LS_FCAT2-JUST = 'C'.
  APPEND LS_FCAT2 TO LT_FCAT2.
  CLEAR: LS_FCAT2.

  LS_FCAT2-FIELDNAME = 'PRQUANT'.
  LS_FCAT2-COLTEXT = '구매요청수량'.
  LS_FCAT2-COL_POS = 4.
  LS_FCAT2-JUST = 'C'.
  APPEND LS_FCAT2 TO LT_FCAT2.
  CLEAR: LS_FCAT2.

  LS_FCAT2-FIELDNAME = 'UNITCODE'.
  LS_FCAT2-COLTEXT = '단위'.
  LS_FCAT2-COL_POS = 5.
  LS_FCAT2-JUST = 'C'.
  APPEND LS_FCAT2 TO LT_FCAT2.
  CLEAR: LS_FCAT2.

  LS_FCAT2-FIELDNAME = 'PRPRICE'.
  LS_FCAT2-COLTEXT = '구매요청금액'.
  LS_FCAT2-COL_POS = 6.
  LS_FCAT2-JUST = 'C'.
  APPEND LS_FCAT2 TO LT_FCAT2.
  CLEAR: LS_FCAT2.

  LS_FCAT2-FIELDNAME = 'CURRENCY'.
  LS_FCAT2-COLTEXT = '화폐단위'.
  LS_FCAT2-COL_POS = 7.
  LS_FCAT2-JUST = 'C'.
  APPEND LS_FCAT2 TO LT_FCAT2.
  CLEAR: LS_FCAT2.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_FCAT120</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_FCAT120 .

  LS_FCAT120-FIELDNAME = 'PRNUM'.
  LS_FCAT120-COLTEXT = '구매요청번호'.
  LS_FCAT120-COL_POS = 1.
  LS_FCAT120-JUST = 'C'.
  APPEND LS_FCAT120 TO LT_FCAT120.
  CLEAR: LS_FCAT120.

  LS_FCAT120-FIELDNAME = 'MATCODE'.
  LS_FCAT120-COLTEXT = '자재번호'.
  LS_FCAT120-COL_POS = 2.
  LS_FCAT120-JUST = 'C'.
  APPEND LS_FCAT120 TO LT_FCAT120.
  CLEAR: LS_FCAT120.

  LS_FCAT120-FIELDNAME = 'MATNAME'.
  LS_FCAT120-COLTEXT = '자재명'.
  LS_FCAT120-COL_POS = 3.
  LS_FCAT120-JUST = 'C'.
  APPEND LS_FCAT120 TO LT_FCAT120.
  CLEAR: LS_FCAT120.

  LS_FCAT120-FIELDNAME = 'PRQUANT'.
  LS_FCAT120-COLTEXT = '구매요청수량'.
  LS_FCAT120-COL_POS = 4.
  LS_FCAT120-JUST = 'C'.
  APPEND LS_FCAT120 TO LT_FCAT120.
  CLEAR: LS_FCAT120.

  LS_FCAT120-FIELDNAME = 'UNITCODE'.
  LS_FCAT120-COLTEXT = '단위'.
  LS_FCAT120-COL_POS = 5.
  LS_FCAT120-JUST = 'C'.
  APPEND LS_FCAT120 TO LT_FCAT120.
  CLEAR: LS_FCAT120.

  LS_FCAT120-FIELDNAME = 'PRPRICE'.
  LS_FCAT120-COLTEXT = '구매요청금액'.
  LS_FCAT120-COL_POS = 6.
  LS_FCAT120-JUST = 'C'.
  APPEND LS_FCAT120 TO LT_FCAT120.
  CLEAR: LS_FCAT120.

  LS_FCAT120-FIELDNAME = 'CURRENCY'.
  LS_FCAT120-COLTEXT = '화폐단위'.
  LS_FCAT120-COL_POS = 7.
  LS_FCAT120-JUST = 'C'.
  APPEND LS_FCAT120 TO LT_FCAT120.
  CLEAR: LS_FCAT120.

ENDFORM.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
