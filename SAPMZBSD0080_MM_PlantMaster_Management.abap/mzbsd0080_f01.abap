<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>MZBSD0080_F01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: MZBSD0080_F01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include MZBSD0080_F01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          MZBSD0080_F01</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form GET_SHRDATA</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBSD_GET_SHRDATA .

  CLEAR: RT_PLTCODE.
  IF ZSBMM1020-PLTCODE IS INITIAL.
    CLEAR: ZSBMM1020-PLTNAME.
  ENDIF.

<font color ="#0000FF">*  라디오버튼 상태에 따라 조건을 만들어줌</font>
  IF ZSBMM1020-ALL = 'X'.
    DEL = '%'.    " ALL -&gt; 전체가 포함되도록  ''
  ELSEIF ZSBMM1020-VALID = 'X'.
    DEL = ''.
  ELSE.
    DEL = 'X'.
  ENDIF.

<font color ="#0000FF">* SELECT-OPTION 테이블 만들기</font>
  IF ZTBMM1020-PLTCODE IS NOT INITIAL.
    RS_PLTCODE-SIGN = 'I'.
    RS_PLTCODE-OPTION = 'EQ'.
    RS_PLTCODE-LOW = ZTBMM1020-PLTCODE.
    APPEND RS_PLTCODE TO RT_PLTCODE.
  ENDIF.

" DATA
  SELECT *
    FROM ZTBMM1020
    INTO TABLE GT_ZTBMM1020
    WHERE PLTCODE IN RT_PLTCODE
    AND DELFLG LIKE DEL.          "삭제 데이터와 같은~ if 조건을 걸었으니 필터링 같이

    IF SY-SUBRC &lt;&gt; 0.  "조건에 일치하는 데이터가 없는 경우 메세지 출력
      MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '015' DISPLAY LIKE 'E'.
    ENDIF.

<font color ="#0000FF">**  플랜트 명 필드에 해당 값 불러오기</font>
<font color ="#0000FF">*  READ TABLE GT_ZTBMM1020 INTO GS_ZTBMM1020 WITH KEY PLTCODE = ZTBMM1020-PLTCODE.</font>
<font color ="#0000FF">*  IF SY-SUBRC = 0.</font>
<font color ="#0000FF">*    ZTBMM1020-PLTNAME = GS_ZTBMM1020-PLTNAME.</font>
<font color ="#0000FF">*  ELSE.</font>
<font color ="#0000FF">**    MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER ''.</font>
<font color ="#0000FF">*  ENDIF.</font>

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form SAVE_DATA</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBSD_SAVE_DATA .

<font color ="#0000FF">*  생성 컨펌 팝업 띄우기 -&gt; LV_ANSWER에 YES를 선택했는지 NO를 선택했는지에 대한 값이 저장됨</font>
 CALL FUNCTION 'POPUP_TO_CONFIRM'
   EXPORTING
    TITLEBAR                    = '플랜트 MASTER 데이터 생성'
    TEXT_QUESTION               = '해당 MASTER 데이터를 생성하시겠습니까?'
    TEXT_BUTTON_1               = 'YES'
    ICON_BUTTON_1               = 'ICON_OKAY'
    TEXT_BUTTON_2               = 'NO'
    ICON_BUTTON_2               = 'ICON_CANCEL'
    DISPLAY_CANCEL_BUTTON       = ''
  IMPORTING
    ANSWER                      = LV_ANSWER
  EXCEPTIONS
    TEXT_NOT_FOUND              = 1
    OTHERS                      = 2.
 IF SY-SUBRC &lt;&gt; 0.
 ENDIF.


<font color ="#0000FF">*    YES 선택한 경우</font>
  IF LV_ANSWER = 1.

    SELECT SINGLE EMPID
      FROM ZTBSD1030
      INTO GV_EMPID
      WHERE LOGID = SY-UNAME.


<font color ="#0000FF">*   마스터 테이블에 데이터 넣기</font>
    DATA: LS_NR TYPE N LENGTH 8.  "NUMBER RANGE
    GS_ZTBMM1020-PLTCODE = PLTCODE110.
    GS_ZTBMM1020-PLTNAME = PLTNAME110.
    GS_ZTBMM1020-PLTADNR = PLTADNR110.
    GS_ZTBMM1020-EMPID = EMPID110.
<font color ="#0000FF">*    TIME STAMP! 넣기</font>
    GS_ZTBMM1020-STAMP_DATE_F = SY-DATUM.
    GS_ZTBMM1020-STAMP_TIME_F = SY-UZEIT.
    GS_ZTBMM1020-STAMP_USER_F = GS_ZTBSD1030-EMPID.
    GS_ZTBMM1020-STAMP_DATE_L = SY-DATUM.
    GS_ZTBMM1020-STAMP_TIME_L = SY-UZEIT.
    GS_ZTBMM1020-STAMP_USER_L = GS_ZTBSD1030-EMPID.


<font color ="#0000FF">* NUMBER RANGE 가져오기</font>
    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        NR_RANGE_NR             = '01'            " NUMBER RANGE의 인터벌 번호
        OBJECT                  = 'ZBBMM1020'    "생성한 NUMBER RANGE OBJECT 이름
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


   GS_ZTBMM1020-PLTCODE = 'PT' && LS_NR. " 코드 앞에 특정 문자 붙여서 코드 완성해주기

    INSERT ZTBMM1020 FROM GS_ZTBMM1020.                     " DB테이블에 완성해준 스트럭쳐 INSERT
    IF SY-SUBRC = 0.                                        " DB테이블에 INSERT 성공하면
      MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '001'.       " 수정 성공 메세지 출력
      APPEND GS_ZTBMM1020 TO GT_ZTBMM1020.                  " 인터널 테이블에도 APPEND
    ELSE.                                                   " DB테이블에 INSERT 실패한 경우
      MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '010'.       " 생성 실패했다고 메세지 출력
    ENDIF.
<font color ="#0000FF">*</font>
    CLEAR:  PLTCODE110, PLTNAME110, PLTADNR110, EMPID110, GS_ZTBMM1020.
<font color ="#0000FF">*</font>
<font color ="#0000FF">*</font>
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
<font color ="#0000FF">*& Form GET_SEL_DATA</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBSD_GET_SEL_DATA .

<font color ="#0000FF">*  선택한 ROW 정보 가져오기 -&gt; 선택한 ROW가 몇 번째 ROW인지 인터널 테이블에 저장해줌</font>
  CALL METHOD GO_ALV-&gt;GET_SELECTED_ROWS
    IMPORTING
      ET_INDEX_ROWS = ET_INDEX_ROW.                " Indexes of Selected Rows

<font color ="#0000FF">*   값을 받아온 인터널 테이블이 초기 값을 가지고 있다면</font>
<font color ="#0000FF">*   (= ROW를 선택하지 않았다는 것) -&gt; 메세지 출력</font>
  IF ET_INDEX_ROW IS INITIAL.
    MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '008' DISPLAY LIKE 'E'. "행을 먼저 선택해주세요!

<font color ="#0000FF">*     값을 받아온 인터널 테이블이 초기 값이 아니라면</font>
<font color ="#0000FF">*     (= ROW를 선택했으면)</font>

    ELSE.
<font color ="#0000FF">*      값을 받아온 인터널 테이블에서 숫자만 가져옴!!</font>
      READ TABLE ET_INDEX_ROW INTO ES_INDEX_ROW INDEX 1.
<font color ="#0000FF">*     (ES_INDEX_ROW의 INDEX 필드에 몇 번째 ROW인지에 대한 숫자가 적혀있음)</font>
      SEL_IDX = ES_INDEX_ROW-INDEX.

<font color ="#0000FF">*      ALV로 보여주는 인터널 테이블에서 해당 ROW의 정보를 스트럭쳐로 가져옴</font>
      READ TABLE GT_ZTBMM1020 INTO GS_ZTBMM1020 INDEX SEL_IDX.

<font color ="#0000FF">*      선택한 ROW가 이미 삭제된 데이터인 경우 -&gt; 이미 삭제된 데이터라고 메세지 출력</font>
      IF GS_ZTBMM1020-DELFLG = 'X'.
            MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '014' DISPLAY LIKE 'E'.

<font color ="#0000FF">*      선택한 ROW가 이미 VALID 삭제된 데이터인 경우</font>
       ELSE. "아니면 'MODIFY'
<font color ="#0000FF">*      -&gt; 수정버튼 누른 이벤트인 경우 수정 팝업 창으로 가기</font>
              IF OK_CODE = 'MOD'.

                CALL SCREEN 120
                  STARTING AT 5 5.

<font color ="#0000FF">*                  -&gt; 삭제버튼 누른 이벤트인 경우 삭제 서브루틴 실행</font>
                    ELSEIF OK_CODE = 'DEL'.
                     PERFORM ZBSD_DEL_SHR. "삭제 서브루틴

               ENDIF.


        ENDIF.


  ENDIF.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBSD_MODIFY_SHR</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBSD_MODIFY_SHR .

<font color ="#0000FF">*  수정 컨펌 팝업 띄우기 -&gt; LV_ANSWER에 YES를 선택했는지 NO를 선택했는지에 대한 값이 저장됨</font>
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      TITLEBAR       = '플랜트 MASTER 데이터 수정'
      TEXT_QUESTION  = '해당 MASTER 데이터를 수정하시겠습니까?'
      TEXT_BUTTON_1  = 'YES'
      ICON_BUTTON_1  = 'ICON_OKAY'
      TEXT_BUTTON_2  = 'NO'
      ICON_BUTTON_2  = 'ICON_CANCEL'
      DISPLAY_CANCEL_BUTTON = ''
    IMPORTING
      ANSWER         = LV_ANSWER
    EXCEPTIONS
      TEXT_NOT_FOUND = 1
      OTHERS         = 2.
  IF SY-SUBRC &lt;&gt; 0.
  ENDIF.


<font color ="#0000FF">*  YES 선택한 경우</font>
  IF LV_ANSWER = 1.

<font color ="#0000FF">*    화면에 입력받은 값들 가져와서 하나의 스트럭쳐로 합쳐줌</font>
    DATA: LS_NR TYPE NUM5.
    GS_ZTBMM1020-PLTCODE = ZTBMM1020-PLTCODE.
    GS_ZTBMM1020-PLTNAME = ZTBMM1020-PLTNAME.
    GS_ZTBMM1020-PLTADNR = ZTBMM1020-PLTADNR.
    GS_ZTBMM1020-EMPID = ZTBMM1020-EMPID.
    "TIME STAMP 수정일 넣기
    GS_ZTBMM1020-STAMP_DATE_L = SY-DATUM.
    GS_ZTBMM1020-STAMP_TIME_L = SY-UZEIT.
    GS_ZTBMM1020-STAMP_USER_L = GS_ZTBSD1030-EMPID.

    " DB 테이블에 완성한 스트럭쳐로 데이터 UPDATE
    UPDATE ZTBMM1020 FROM GS_ZTBMM1020.

      "  MODIFY = INSERT + UPDATE 동시에!
      " 없으면 INSERT 추가해주고 있으면 UPDATE! AND INTERNAL TABLE 에는 UPDATE 기능!
      IF SY-SUBRC = 0.
        MODIFY GT_ZTBMM1020 FROM GS_ZTBMM1020 INDEX SEL_IDX. " 인터널 테이블도 수정해줌 - 인터널 테이블 수정 시 인덱스가 필요하기 때문에 이전에 받아둔 SEL_IDX 사용
        MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '011'.     " 수정 성공했다고 메세지 출력
      ELSE.
          MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '012'.  " 실패했다고 메세지 출력
      ENDIF.

      CLEAR: ZTBMM1020-PLTCODE, ZTBMM1020-PLTNAME, ZTBMM1020-PLTADNR, ZTBMM1020-EMPID.

  ENDIF.

ENDFORM.

<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBSD_DEL_SHR</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBSD_DEL_SHR .

<font color ="#0000FF">*  삭제 컨펌 팝업 띄우기 -&gt; LV_ANSWER에 YES를 선택했는지 NO를 선택했는지에 대한 값이 저장됨</font>

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
     TITLEBAR                    = '플랜트 MASTER 데이터 삭제'
     TEXT_QUESTION               = '해당 MASTER 데이터를 삭제하시겠습니까?'
     TEXT_BUTTON_1               = 'YES'
      ICON_BUTTON_1              = 'ICON_OKAY'
      TEXT_BUTTON_2              = 'NO'
      ICON_BUTTON_2              = 'ICON_CANCEL'
     DISPLAY_CANCEL_BUTTON       = ''
   IMPORTING
     ANSWER                      = LV_ANSWER
   EXCEPTIONS
     TEXT_NOT_FOUND              = 1
     OTHERS                      = 2.
  IF SY-SUBRC &lt;&gt; 0.
  ENDIF.

<font color ="#0000FF">*  YES 선택한 경우</font>
   IF  LV_ANSWER = 1.

       GS_ZTBMM1020-STAMP_USER_L = GS_ZTBSD1030-EMPID.
       GS_ZTBMM1020-DELFLG = 'X'.           " DELFLG 값을 X로 바꿔줌

     UPDATE ZTBMM1020 FROM GS_ZTBMM1020.  " DB 테이블 업데이트

        IF SY-SUBRC = 0.                  " DB 테이블 업데이트 성공했으면
          "인터널 테이블도 수정해줌 -&gt; 몇번째줄을 수정해주는지 INDEX가 필요하기 때문에 이전에 받은 SEL_IDX 사용
           MODIFY GT_ZTBMM1020 FROM GS_ZTBMM1020 INDEX SEL_IDX.
           MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '013' DISPLAY LIKE 'E'. "데이터가 성공적으로 삭제되었습니다.
        ELSE.
           MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '007' DISPLAY LIKE 'E'. "데이터 삭제 오류가 발생했습니다.
       ENDIF.


<font color ="#0000FF">*       CLEAR: GS_ZTBMM1020.</font>
   ENDIF.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMB_SET_LAYOUT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBSD_SET_LAYOUT .

  GS_LAYOUT-ZEBRA = 'X'.      "ALV 행 색상
  GS_LAYOUT-CWIDTH_OPT = 'A'. "필드 가로길이 자동설정
  GS_LAYOUT-GRID_TITLE = '플랜트 MASTER ALV 화면'. "ALV 타이틀 설정
  GS_LAYOUT-SEL_MODE = 'B'.

  "A : 여러행, 여러열 선택 (행선택 버튼 표시)
  "B : 단일행, 여러열 선택 (행선택 버튼 없음) / SPACE : B와 동일
  "C : 여러행, 여러열 선택 (행선택 버튼 없음)
  "D : 여러행, 여러열 및 셀별로 선택(행선택 버튼 표시)


ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_SORT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBSD_SET_SORT .

  GS_SORT-FIELDNAME = 'PLTCODE'.
  GS_SORT-DOWN = 'X'.             "내림차순정렬
<font color ="#0000FF">* GS_SORT-IS_SORT-UP = 'X'        "오름차순 정렬</font>

  APPEND GS_SORT TO GT_SORT.

ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBSD_CLEAR_ALL</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBSD_CLEAR_ALL .
  CLEAR: GT_ZTBMM1020, GS_ZTBMM1020, ZSBMM1020 ,ZTBMM1020.
  ZSBMM1020-VALID = 'X'.

<font color ="#0000FF">* ALV REFRESH -&gt; 변경 사항 적용해서 화면에 보여주기 위함</font>
    CALL METHOD GO_ALV-&gt;REFRESH_TABLE_DISPLAY
      EXCEPTIONS
        FINISHED = 1
        OTHERS   = 2.
    IF SY-SUBRC &lt;&gt; 0.
    ENDIF.
ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_FCAT</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBSD_SET_FCAT .

  DATA: LS_FCAT TYPE LVC_S_FCAT.

  LS_FCAT-FIELDNAME = 'DELFLG'.
  LS_FCAT-CHECKBOX = 'X'.
  APPEND LS_FCAT TO GT_FCAT.
  CLEAR : LS_FCAT.


  LS_FCAT-FIELDNAME = 'STAMP_USER_F'.
  LS_FCAT-HOTSPOT = 'X'.

  APPEND LS_FCAT TO GT_FCAT. "쌓고 저장한다. 특성값
<font color ="#0000FF">*  ALV설정하는 곳에 보면 필드 카탈로그가 있는데 거기에다가 옵션값으로 이테이블을 넣어주는것</font>
  CLEAR: LS_FCAT.

  LS_FCAT-FIELDNAME = 'STAMP_USER_L'.
  LS_FCAT-HOTSPOT = 'X'.

  APPEND LS_FCAT TO GT_FCAT. "쌓고 저장한다.
  CLEAR: LS_FCAT.
ENDFORM.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
