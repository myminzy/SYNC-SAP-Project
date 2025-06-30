<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBRMM0020_O01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBRMM0020_O01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include ZBRMM0020_O01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          ZBRMM0020_O01</font>
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
<font color ="#0000FF">*& Module SET_ALV OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE SET_ALV OUTPUT.

  IF GO_DOCK IS INITIAL.
<font color ="#0000FF">*  ---Docking Container 생성.</font>
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

<font color ="#0000FF">*---Split으로 화면 분할.</font>
    CREATE OBJECT GO_SPLIT
      EXPORTING
        ROWS    = 2
        COLUMNS = 1
        PARENT  = GO_DOCK.

<font color ="#0000FF">*---스플릿 화면에 컨테이너 올리기.</font>
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

<font color ="#0000FF">*---스플릿 화면 크기 조정.</font>
    CALL METHOD GO_SPLIT-&gt;SET_ROW_HEIGHT
      EXPORTING
        ID         = 1
        HEIGHT     = 50
      EXCEPTIONS
        CNTL_ERROR = 1.

<font color ="#0000FF">*---분할된 Docking Container에 각각 ALV 올리기.</font>
    CREATE OBJECT GO_ALV1
      EXPORTING
        I_PARENT = GO_TOP.

    CREATE OBJECT GO_ALV2
      EXPORTING
        I_PARENT = GO_BOT.

    SET HANDLER LCL_EVENT_HANDLER=&gt;ON_TOOLBAR1 FOR GO_ALV1. "item 조회 버튼
    SET HANDLER LCL_EVENT_HANDLER=&gt;ON_TOOLBAR2 FOR GO_ALV1. "구매오더미완료 필터 버튼
    SET HANDLER LCL_EVENT_HANDLER=&gt;ON_TOOLBAR3 FOR GO_ALV1. "구매오더완료 필터 버튼
    SET HANDLER LCL_EVENT_HANDLER=&gt;ON_TOOLBAR5 FOR GO_ALV1. "반려필터 버튼
    SET HANDLER LCL_EVENT_HANDLER=&gt;ON_TOOLBAR4 FOR GO_ALV1. "전체조회 필터 버튼

    SET HANDLER LCL_EVENT_HANDLER=&gt;ON_USER_COMMAND1 FOR GO_ALV1.
    SET HANDLER LCL_EVENT_HANDLER=&gt;ON_HOTSPOT_CLICK FOR GO_ALV1. "사원 ID 조회

    "ALV Create
    PERFORM ZBMM_SET_ALV1.
    PERFORM ZBMM_SET_ALV2.

  ELSE.

    " ALV REFRESH -&gt; 변경 사항 적용해서 화면에 보여주기 위함
    CALL METHOD GO_ALV1-&gt;REFRESH_TABLE_DISPLAY
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
<font color ="#0000FF">*& Module STATUS_0120 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE STATUS_0120 OUTPUT.

<font color ="#0000FF">*  SET PF-STATUS 'S120'.</font>
  SET TITLEBAR 'T120'.

  "반려사유 필드 (ZTBMM0010-PRNG)
  "GV_VF: 확정 버튼 GV_VF2: 반려버튼 120
  IF ZTBMM0010-PRNGT IS NOT INITIAL AND GV_VF EQ 'X' AND GV_VF2 EQ 'X'.
    SET PF-STATUS 'CAC_0120'.   "반려사유가 값이 있을때  = 반려버튼(GV_VF2) 반려확정(GV_VF2)누른 후 =&gt; 버튼/취소X 버튼
  ELSEIF ZTBMM0010-PRNGT IS NOT INITIAL AND GV_VF2 EQ 'X'.
    SET PF-STATUS '0120_REJECT'."반려사유가 값이 있을때 = 반려버튼(GV_VF2) 누른 후 =&gt; 확정/취소 버튼
  ELSE.
    SET PF-STATUS 'S120'. "초기값 버튼 세팅 =&gt; "승인/반려/닫기 버튼
  ENDIF.


ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module SET_ALV_0120 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE SET_ALV_0120 OUTPUT.
  IF GO_CONT120 IS INITIAL.

    CREATE OBJECT GO_CONT120
      EXPORTING
        CONTAINER_NAME = 'CON1'.             " Name of the Screen CustCtrl Name to Link Container To
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

    CREATE OBJECT GO_ALV120
      EXPORTING
        I_PARENT = GO_CONT120.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

    PERFORM ZBMM_SET_LAYOUT120.
    PERFORM ZBMM_SET_FCAT120.


    CALL METHOD GO_ALV120-&gt;SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
        I_STRUCTURE_NAME              = 'ZTBMM0011'
        I_DEFAULT                     = 'X'
        IS_LAYOUT                     = LS_LAYOUT120
      CHANGING
        IT_OUTTAB                     = GT_ZTBMM0011
        IT_FIELDCATALOG               = LT_FCAT120
      EXCEPTIONS
        INVALID_PARAMETER_COMBINATION = 1
        PROGRAM_ERROR                 = 2
        TOO_MANY_LINES                = 3
        OTHERS                        = 4.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.


  ELSE.

    "ALV 레이아웃은 그대로 유지하면서 REFRESH!!
    CALL METHOD GO_ALV120-&gt;REFRESH_TABLE_DISPLAY
      EXCEPTIONS
        FINISHED = 1
        OTHERS   = 2.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.

  ENDIF.


ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module CLEAR_OK_CODE_0120 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE CLEAR_OK_CODE_0120 OUTPUT.
  CLEAR: OK_CODE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module SET_FIELD_0120 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE SET_FIELD_0120 OUTPUT.

  "120 팝업창 세팅

<font color ="#0000FF">*   "로그인 ID로 사원마스터에 사원ID 가져오기</font>
  SELECT *
   FROM ZTBSD1030
    INTO TABLE GT_ZTBSD1030.

  READ TABLE GT_ZTBSD1030 INTO GS_ZTBSD1030 WITH KEY LOGID = SY-UNAME.
  IF SY-SUBRC = 0.
    ZTBSD1030-EMPID = GS_ZTBSD1030-EMPID.
  ENDIF.

  MOVE-CORRESPONDING GS_ZTBSD1030 TO ZTBSD1030.

  "구매요청 header
  MOVE-CORRESPONDING GS_ZTBMM0010 TO ZTBMM0010.


  " 팝업 ALV - item
  "선택한 한줄에 대한 펑션
  DATA: LT_ROWS120 TYPE LVC_T_ROW.
  DATA: LS_ROWS120 LIKE LINE OF LT_ROWS120.

  GO_ALV1-&gt;GET_SELECTED_ROWS(
       IMPORTING
        ET_INDEX_ROWS = LT_ROWS120 ).

  READ TABLE LT_ROWS120 INTO LS_ROWS120 INDEX 1.

  IF LS_ROWS120 IS NOT INITIAL.

    READ TABLE GT_ZTBMM0010 INTO GS_ZTBMM0010 INDEX LS_ROWS120-INDEX.

       SELECT *
      FROM ZTBMM0010 AS A "구매요청 헤더
      JOIN ZTBMM0011 AS B "구매요청 아이템
      ON A~PRNUM EQ B~PRNUM "구매요청번호
      JOIN ZTBMM1011 AS C "자재명
      ON B~MATCODE EQ C~MATCODE "자재번호
      WHERE A~PRNUM EQ @GS_ZTBMM0010-PRNUM "구매요청 번호
       INTO CORRESPONDING FIELDS OF TABLE @GT_ZTBMM0011.

  ENDIF.

<font color ="#0000FF">*-- 팝업창에 아이콘 띄우기</font>
  "STATUS ICON
  DATA: LV_ICON TYPE ICONS-TEXT.

  IF ZTBMM0010-STATUS EQ 'N'.
    LV_ICON = 'ICON_LED_YELLOW'.   " 반려
<font color ="#0000FF">*</font>
  ELSEIF ZTBMM0010-STATUS EQ 'X'.  " 미승인
    LV_ICON = 'ICON_LED_RED'.
  ELSE.
    "구매요청 완료 A 인경우.
    LV_ICON = 'ICON_LED_GREEN'.    " 승인
  ENDIF.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      NAME   = LV_ICON
    IMPORTING
      RESULT = STATUS.


ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module MODIFY_SCREEN_0120 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE MODIFY_SCREEN_0120 OUTPUT.

  " 상태플래그 값이 'X'인 경우 반려사유 입력필드 열림
  " 구매요청 미완료
  IF ZTBMM0010-STATUS EQ 'X'.

    IF ZTBMM0010-STATUS IS NOT INITIAL.
      LOOP AT SCREEN.
        IF SCREEN-GROUP1 EQ 'RE' AND SCREEN-INPUT = 1. "열어라.R
          SET PF-STATUS 'CAC_0120'.
        ENDIF.
        IF SCREEN-GROUP1 EQ 'RE' AND GV_VF2 EQ 'X'. "반려 버튼 GV_VF2 체크후
          SCREEN-INPUT = 1. "열어라.
          MODIFY SCREEN.
        ENDIF.
      ENDLOOP.

      "반려버튼 분기
      IF GV_VF2 EQ 'X' AND GV_VF EQ 'X'. "반려버튼 / 반려확정 누른 후
        SET PF-STATUS 'CAC_0120'. "취소 버튼만 있는거 호출
<font color ="#0000FF">*        BREAK-POINT .</font>
      ELSEIF OK_CODE EQ 'ORDER'.  "구매오더결제 누르면 승인/반려/취소 버튼 3개 있는거 호출
        SET PF-STATUS 'S120'.
      ELSE.
        SET PF-STATUS '0120_REJECT'.  "반려버튼 호출 반려확성/ 반려취소 버튼
      ENDIF.
<font color ="#0000FF">*       MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '036' DISPLAY 'E'.</font>
    ENDIF.

    "구매요청 승인버튼 분기
    IF GV_VF1 EQ 'X'.
      SET PF-STATUS 'CAC_0120'. "취소 버튼만 있는거 호출
    ENDIF.

    "반려생태 일때
  ELSEIF  ZTBMM0010-STATUS EQ 'N'. "반려생태 일때 반려버튼 누르면
    IF GV_VF2 EQ 'X'.
      SET PF-STATUS 'CAC_0120'. "취소 버튼만 있는거 호출
    ELSEIF GV_VF1 EQ 'X'.  "구매요청 승인 상태 일때 승인버튼 누르면
      SET PF-STATUS 'CAC_0120'. "취소 버튼만 있는거 호출
    ENDIF.


    "구매요청 승인 상태
  ELSEIF  ZTBMM0010-STATUS EQ 'A'.
    IF GV_VF2 EQ 'X'. "구매요청 승인 상태 일때 반려버튼 누르면
      SET PF-STATUS 'CAC_0120'. "취소 버튼만 있는거 호출
    ELSEIF GV_VF1 EQ 'X'.  "구매요청 승인 상태 일때 승인버튼 누르면
      SET PF-STATUS 'CAC_0120'. "취소 버튼만 있는거 호출
    ENDIF.


  ENDIF.

ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module SET_STATUS_RE_0120 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE SET_STATUS_RE_0120 OUTPUT.

  "반려사유 값 있으면
  IF ZTBMM0010-PRNGT IS NOT INITIAL.
    LOOP AT SCREEN.
      IF SCREEN-GROUP1 EQ 'RE'.
        SCREEN-INPUT = 0.
<font color ="#0000FF">*        ELSEIF ZTBMM0010-STATUS EQ 'A'.</font>
<font color ="#0000FF">*        SCREEN-INPUT = 0.</font>
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.

<font color ="#0000FF">*CLEAR: ZTBMM0010-PRNGT.</font>
<font color ="#0000FF">*SET PF-STATUS 'CAC_1020'.</font>
<font color ="#0000FF">*  CALL FUNCTION 'SAPGUI_SET_FUNCTIONCODE' "임의로 PBO 실행해서 판매오더 생성 박스의 스트럭쳐도 업데이트</font>
<font color ="#0000FF">*    EXPORTING</font>
<font color ="#0000FF">*      FUNCTIONCODE           = 'ENTER'</font>
<font color ="#0000FF">*    EXCEPTIONS</font>
<font color ="#0000FF">*      FUNCTION_NOT_SUPPORTED = 1</font>
<font color ="#0000FF">*      OTHERS                 = 2.</font>

  ENDIF.

ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module CLEAR_OK_CODE_0130 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE CLEAR_OK_CODE_0130 OUTPUT.
  CLEAR: OK_CODE.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module STATUS_0130 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE STATUS_0130 OUTPUT.
<font color ="#0000FF">*  IF .</font>
<font color ="#0000FF">*    SET PF-STATUS 'S130' EXCLUDING 'OKAY130'.</font>
<font color ="#0000FF">*  ELSE.</font>
<font color ="#0000FF">*    SET PF-STATUS 'S130'.</font>
<font color ="#0000FF">*  ENDIF.</font>

  SET PF-STATUS 'S130'.
  SET TITLEBAR 'T130'.
ENDMODULE.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Module GET_EMP_DATA_0130 OUTPUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
MODULE GET_EMP_DATA_0130 OUTPUT.

  SELECT SINGLE *
    FROM ZTBSD1030
    WHERE EMPID = GV_EMPID.

ENDMODULE.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
