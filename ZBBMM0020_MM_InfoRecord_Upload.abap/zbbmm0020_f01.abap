<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>ZBBMM0020_F01</title>
</head>
<body bgcolor="#FFFFE0">
<font size="3" face = "Arial" color="#000000"><b>Code listing for: ZBBMM0020_F01</b></font>
<br>
<font size="3" face = "Arial" color="#000000"><b>Description:  Include ZBBMM0020_F01</b></font>
<hr>
<pre width="100">
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Include          ZBBMM0020_F01</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form GET_FILE_PATH</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM GET_FILE_PATH .
  "파일 오픈 METHOD 호출
  CALL METHOD CL_GUI_FRONTEND_SERVICES=&gt;FILE_OPEN_DIALOG
  " 확장자 EXCEL 로만 선택 가능.
    EXPORTING
      DEFAULT_EXTENSION = CL_GUI_FRONTEND_SERVICES=&gt;FILETYPE_EXCEL
      FILE_FILTER       = CL_GUI_FRONTEND_SERVICES=&gt;FILETYPE_EXCEL
    CHANGING
      FILE_TABLE        = GT_FILE          "클릭한 파일이름(바이너리 경로) 가 담김
      RC                = GV_RC_FILEPATH.  "파일수 또는 오류가 발생했을경우 -1을 반환한다.

  " 파일을 정상적으로 선택했으면, WA에 할당.
  " 파일 업로드 성공 -&gt; PA_PATH에 파일 경로 저장
  IF GT_FILE IS NOT INITIAL.
    READ TABLE GT_FILE INTO GS_FILE INDEX 1. "경로를 받은 테이블에서 첫번째 라인을 변수에 입력
    PA_PATH = GS_FILE-FILENAME.
  ELSE.
    MESSAGE I000 DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form DOWN_FILE</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM DOWN_FILE .

  " EXCEL FILE 샘플 다운로드 로직에 필요한 변수 선언.
  DATA : LV_FILENAME    TYPE STRING,
         LV_PATH        TYPE STRING,
         LV_FULLPATH    TYPE STRING,
         LV_USER_ACTION TYPE I,
         LV_RC          TYPE SY-SUBRC,
         LS_KEY         TYPE WWWDATATAB.

  "샘플양식 할당
  "SMW0 에 등록한 EXCEL에 대한 WWWDATA DATA를 LS_KEY에 할당.
  SELECT SINGLE * FROM WWWDATA
    INTO CORRESPONDING FIELDS OF LS_KEY
    WHERE OBJID = 'ZTBMM0070_XLS_TEMPLATE'.

  " 파일 이름 자동 생성. 날짜 추가
  CONCATENATE '인포레코드 MASTER_' SY-DATUM SY-UZEIT INTO LV_FILENAME.

  "확장자명, 파일명 받기
  CALL METHOD CL_GUI_FRONTEND_SERVICES=&gt;FILE_SAVE_DIALOG
    EXPORTING
      DEFAULT_EXTENSION         = 'XLSX'         "기본확장자
      DEFAULT_FILE_NAME         = LV_FILENAME    "파일명
    CHANGING
      FILENAME                  = LV_FILENAME
      PATH                      = LV_PATH             " File Name to Save
      FULLPATH                  = LV_FULLPATH         " Path to File
      USER_ACTION               = LV_USER_ACTION      " Path + File Name
    EXCEPTIONS                                          "User Action (C Class Const ACTION_OK, ACTION_OVERWRITE etc)
      CNTL_ERROR                = 1
      ERROR_NO_GUI              = 2
      NOT_SUPPORTED_BY_GUI      = 3
      INVALID_DEFAULT_FILE_NAME = 4
      OTHERS                    = 5.

  " 사용자가 다운로드 중 취소했을 때 EXIT.
  IF LV_USER_ACTION = CL_GUI_FRONTEND_SERVICES=&gt;ACTION_CANCEL.
    EXIT.
  ENDIF.

  "파일 다운로드
  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'
    EXPORTING
      KEY         = LS_KEY
      DESTINATION = CONV LOCALFILE( LV_FULLPATH ). "다운로드 경로 local file

  " LV_FULLPATH 에 할당한 SMW0 EXCEL 실행.
  CALL METHOD CL_GUI_FRONTEND_SERVICES=&gt;EXECUTE
    EXPORTING
      DOCUMENT               = LV_FULLPATH " Path+Name to Document
    EXCEPTIONS
      CNTL_ERROR             = 1
      ERROR_NO_GUI           = 2
      BAD_PARAMETER          = 3
      FILE_NOT_FOUND         = 4
      PATH_NOT_FOUND         = 5
      FILE_EXTENSION_UNKNOWN = 6
      ERROR_EXECUTE_FAILED   = 7
      SYNCHRONOUS_FAILED     = 8
      NOT_SUPPORTED_BY_GUI   = 9
      OTHERS                 = 10.

  IF SY-SUBRC = 0.
    MESSAGE S002.
  ELSE.
    MESSAGE I003 DISPLAY LIKE 'E'.
  ENDIF.



ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form CHECK_EXCEL</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM CHECK_EXCEL .
  " PA_PATH PARAMETER에 파일을 선택하지 않았을 때 알람.
  DATA : LV_FILE LIKE RLGRAP-FILENAME.

  " C:\가 기본이니까 그 이후 경로를 확인해서 내용이 없으면 선택 안 했다는 것
  LV_FILE = PA_PATH+3.

  IF LV_FILE = SPACE.
<font color ="#0000FF">*    MESSAGE I022 DISPLAY LIKE 'E'.</font>
    LEAVE LIST-PROCESSING. " 실행중인 목록 처리 블록에서 빠져나와 다음 명령문 실행
  ENDIF.


ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form UPLOAD_EXCEL</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM UPLOAD_EXCEL .

  DATA : LT_EXCEL      TYPE TABLE OF ALSMEX_TABLINE, "엑셀저장 테이블
         LV_BEGIN_ROW  TYPE I,                    "시작 열번호
         LV_END_ROW    TYPE I,                    "끝낼 열번호
         LV_RANGE_ROWS TYPE I VALUE 10000,        "최대행 갯수
         LV_ROW        TYPE KCD_EX_ROW_N VALUE 1.


  CLEAR : LV_BEGIN_ROW, LV_END_ROW.

  LV_BEGIN_ROW = 3. "엑셀에서 읽기 시작할 행번호
  LV_END_ROW   = LV_BEGIN_ROW + LV_RANGE_ROWS - 1. "시작할 행 번호에서 - 최대 행갯수가 마지막 행인거

  CLEAR : GT_DATA.


  "EXCEL 데이터 발췌 인터널 테이블
  DATA : GT_EXCEL TYPE TABLE OF ALSMEX_TABLINE,  "소수점, 기호 없애고 담을 테이블.
         GS_EXCEL LIKE LINE OF GT_EXCEL.

<font color ="#0000FF">*</font>
<font color ="#0000FF">*  "EXCEL 데이터 발췌</font>
<font color ="#0000FF">*  "필드 심볼을 이용해서 같은 컬럼 값의 벨류를 할당.</font>
<font color ="#0000FF">*  FIELD-SYMBOLS: &lt;FS_COMP&gt; TYPE ANY.</font>

<font color ="#0000FF">*  " 데이터 발췌</font>
<font color ="#0000FF">*  " EXCEL DATA를 INTERNAL TABLE에 담기.</font>
<font color ="#0000FF">*  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'</font>
<font color ="#0000FF">*    EXPORTING</font>
<font color ="#0000FF">*      FILENAME                = PA_PATH "파일경로</font>
<font color ="#0000FF">*      I_BEGIN_COL             = 2       "compiler가 인실할 시작 열번호</font>
<font color ="#0000FF">*      I_BEGIN_ROW             = 3       "compiler가 인실할 시작 행번호</font>
<font color ="#0000FF">*      I_END_COL               = 10      "excel에 명시한 필드 갯수</font>
<font color ="#0000FF">*      I_END_ROW               = 100000  "최대행 갯수</font>
<font color ="#0000FF">*    TABLES</font>
<font color ="#0000FF">*      INTERN                  = GT_EXCEL "해당 테이블에 값 넣기. " 펑션 수행결과 excel data를 받은 인터널 테이블 Rows for Table with Excel Data</font>
<font color ="#0000FF">*    EXCEPTIONS</font>
<font color ="#0000FF">*      INCONSISTENT_PARAMETERS = 1</font>
<font color ="#0000FF">*      UPLOAD_OLE              = 2</font>
<font color ="#0000FF">*      OTHERS                  = 3.</font>

<font color ="#0000FF">*  DO.</font>
  CLEAR LT_EXCEL.

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'
    EXPORTING
      FILENAME                = PA_PATH
      I_BEGIN_COL             = 2  "엑셀에서 읽을 시작 칼럼 번호
      I_BEGIN_ROW             = LV_BEGIN_ROW
      I_END_COL               = 11  "엑셀에서 읽을 칼럼 개수
      I_END_ROW               = LV_END_ROW
    TABLES
      INTERN                  = lT_EXCEL
    EXCEPTIONS
      INCONSISTENT_PARAMETERS = 1
      UPLOAD_OLE              = 2
      OTHERS                  = 3.


  IF LT_EXCEL IS NOT INITIAL.
    APPEND LINES OF LT_EXCEL TO GT_EXCEL.
  ENDIF.

  " EXCEL DATA 가져오기에 실패했을 때.
  IF SY-SUBRC &lt;&gt; 0.
    MESSAGE I029 DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.

  " EXCEL DATA 에 DATA가 없을 때.
  IF GT_EXCEL IS INITIAL.
    MESSAGE I005 DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.


  " EXCEL DATA 가져오기에 실패했을 때.
<font color ="#0000FF">*  IF SY-SUBRC &lt;&gt; 0.</font>
<font color ="#0000FF">**   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO</font>
<font color ="#0000FF">**     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.</font>
<font color ="#0000FF">*    LEAVE LIST-PROCESSING.  "MESSAGE E를 쓰고 새 창 안띄우고 싶을 때</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">**    STOP 과 LEAVE LIST-PROCESSING 둘 다 START-OF-SELECTION 에서 사용가능하지만, STOP 을 만났을 경우 해당 부분에서 멈춤으로 프로그램이 종료 되고,</font>
<font color ="#0000FF">**   LEAVE LIST-PROCESSING 을 만났을 경우는 SELECTION-SCREEN 화면으로 돌아가며 종료 된다.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*  ENDIF.</font>
<font color ="#0000FF">*  "</font>
<font color ="#0000FF">*  "  " EXCEL DATA 에 DATA가 없을 때.</font>
<font color ="#0000FF">*  IF SY-SUBRC &lt;&gt; 0.</font>
<font color ="#0000FF">**   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO</font>
<font color ="#0000FF">**     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.</font>
<font color ="#0000FF">*    LEAVE LIST-PROCESSING.</font>
<font color ="#0000FF">*  ENDIF.</font>



  LOOP AT GT_EXCEL INTO GS_EXCEL.

    IF LV_ROW NE GS_EXCEL-ROW.
      LV_ROW = GS_EXCEL-ROW.

      APPEND GS_DATA TO GT_DATA.
      CLEAR  GS_DATA.
    ENDIF.

    CASE GS_EXCEL-COL.
      WHEN 1. "자재번호
        GS_DATA-MATCODE = GS_EXCEL-VALUE.

      WHEN 2. "거래처 코드
        GS_DATA-BPCODE = GS_EXCEL-VALUE.

      WHEN 3. "구매단위수량
<font color ="#0000FF">* 숫자의 천단위 , 없애기</font>
        REPLACE ALL OCCURRENCES OF ',' IN GS_EXCEL-VALUE WITH ''.

        GS_DATA-INFQUANT = GS_EXCEL-VALUE.

      WHEN 4. "단위
        GS_DATA-UNITCODE = GS_EXCEL-VALUE.

      WHEN 5. "구매단위 당 단가
<font color ="#0000FF">* 숫자의 천단위 , 없애기</font>
        REPLACE ALL OCCURRENCES OF ',' IN GS_EXCEL-VALUE WITH ''.

        GS_DATA-INFPRICE = GS_EXCEL-VALUE.

      WHEN 6. "통화키 화폐단위
        GS_DATA-CURRENCY = GS_EXCEL-VALUE.

      WHEN 7. "리드타임
        GS_DATA-LDTIME = GS_EXCEL-VALUE.

      WHEN 8. "지급조건
        GS_DATA-ZTERM = GS_EXCEL-VALUE.

      WHEN 9. "계약시작일
<font color ="#0000FF">* 날짜 슬래시 없애기</font>
        REPLACE ALL OCCURRENCES OF '-' IN GS_EXCEL-VALUE WITH ''.
        REPLACE ALL OCCURRENCES OF '.' IN GS_EXCEL-VALUE WITH ''.
        GS_DATA-DATSR = GS_EXCEL-VALUE.

      WHEN 10. "계약종료일
<font color ="#0000FF">* 날짜 슬래시 없애기</font>
        REPLACE ALL OCCURRENCES OF '-' IN GS_EXCEL-VALUE WITH ''.
        REPLACE ALL OCCURRENCES OF '.' IN GS_EXCEL-VALUE WITH ''.
        GS_DATA-DATEN = GS_EXCEL-VALUE.

    ENDCASE.

  ENDLOOP.

<font color ="#0000FF">* 마지막 행</font>
  APPEND GS_DATA TO GT_DATA.
  CLEAR  GS_DATA.


ENDFORM.


<font color ="#0000FF">*  LOOP AT GT_EXCEL INTO GS_EXCEL.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">**    AT NEW ROW.</font>
<font color ="#0000FF">**      CLEAR: GT_DATA.</font>
<font color ="#0000FF">**    ENDAT.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    "ASSIGN COMPONENT 구문을 사용해서 STRUCTURE에 값을 할당.</font>
<font color ="#0000FF">*    ASSIGN COMPONENT GS_EXCEL-COL OF STRUCTURE GS_DATA TO &lt;FS_COMP&gt;. "COL값에 따라 GS_DATA값을 넣어줌</font>
<font color ="#0000FF">**    &lt;FS_COMP&gt; = GS_EXCEL-VALUE. "ROW값이 변경되기 직전 마지만 VALUE에서 수행</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    IF SY-SUBRC = 0.</font>
<font color ="#0000FF">*      TRY.</font>
<font color ="#0000FF">*          &lt;FS_COMP&gt; = GS_EXCEL-VALUE.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*        CATCH CX_SY_CONVERSION_NO_NUMBER.</font>
<font color ="#0000FF">**        CATCH CX_SY_CONVERSION_LOST_DECIMALS.</font>
<font color ="#0000FF">*        CATCH CX_SY_CONVERSION_OVERFLOW.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*      ENDTRY.</font>
<font color ="#0000FF">*    ENDIF.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*    AT END OF ROW. "나열된 데이터를 행으로 변환. 인터널 테이블에 쌓아줌</font>
<font color ="#0000FF">*      APPEND GS_DATA TO GT_DATA.</font>
<font color ="#0000FF">*      CLEAR : GS_DATA.</font>
<font color ="#0000FF">*    ENDAT.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*  ENDLOOP.</font>



<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SET_LAYO</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SET_LAYO .
  GS_LAYO-CWIDTH_OPT = 'A'.
  GS_LAYO-GRID_TITLE = 'Excel 인포레코드 데이터 리스트'.
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

  GS_FCAT-FIELDNAME = 'INFNUM'.
  GS_FCAT-NO_OUT = 'X'.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR: GS_FCAT.

  GS_FCAT-FIELDNAME = 'DELFLG'.
  GS_FCAT-NO_OUT = 'X'.
  APPEND GS_FCAT TO GT_FCAT.
  CLEAR: GS_FCAT.


ENDFORM.
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& Form ZBMM_SAVE_EXCEL</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
<font color ="#0000FF">*& --&gt;  p1        text</font>
<font color ="#0000FF">*& &lt;--  p2        text</font>
<font color ="#0000FF">*&---------------------------------------------------------------------*</font>
FORM ZBMM_SAVE_EXCEL .

  DATA: LV_ANSWER.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
<font color ="#0000FF">*     TITLEBAR              = ' '</font>
<font color ="#0000FF">*     DIAGNOSE_OBJECT       = ' '</font>
      TEXT_QUESTION         = 'Excel 데이터를 저장하시겠습니까?'
      TEXT_BUTTON_1         = 'YES'
      ICON_BUTTON_1         = 'ICON_OKAY'
      TEXT_BUTTON_2         = 'NO'
      ICON_BUTTON_2         = 'ICON_CANCEL'
      DEFAULT_BUTTON        = '1'
      DISPLAY_CANCEL_BUTTON = ''
<font color ="#0000FF">*     USERDEFINED_F1_HELP   = ' '</font>
<font color ="#0000FF">*     START_COLUMN          = 25</font>
<font color ="#0000FF">*     START_ROW             = 6</font>
<font color ="#0000FF">*     POPUP_TYPE            =</font>
<font color ="#0000FF">*     IV_QUICKINFO_BUTTON_1 = ' '</font>
<font color ="#0000FF">*     IV_QUICKINFO_BUTTON_2 = ' '.</font>
    IMPORTING
      ANSWER                = LV_ANSWER.
  IF SY-SUBRC &lt;&gt; 0.
  ENDIF.

  "인포레코드 채번
  DATA: LS_NR TYPE NUM7.
  DATA: Lv_INF TYPE STRING.

  "YES
  IF LV_ANSWER = 1.

    "EXCEL 데이터가 현재 GT_DATA INTERNAL TABLE에 있으므로, GT_ZTBMM0070에 옮겨줌
    MOVE-CORRESPONDING GT_DATA TO GT_ZTBMM0070.

    " GT_ZTBMM0070 TABLE에 INFNUM 값 입력.
    LOOP AT GT_ZTBMM0070 INTO GS_ZTBMM0070.

      "INFNUM 인포레코드 번호 체번
      CALL FUNCTION 'NUMBER_GET_NEXT'
        EXPORTING
          NR_RANGE_NR             = '01'
          OBJECT                  = 'ZBBMM0070'
        IMPORTING
          NUMBER                  = LS_NR
        EXCEPTIONS
          INTERVAL_NOT_FOUND      = 1
          NUMBER_RANGE_NOT_INTERN = 2
          OBJECT_NOT_FOUND        = 3
          QUANTITY_IS_0           = 4
          QUANTITY_IS_NOT_1       = 5
          INTERVAL_OVERFLOW       = 6
          BUFFER_OVERFLOW         = 7
          OTHERS                  = 8.

      IF SY-SUBRC = 0.
<font color ="#0000FF">*        GS_ZTBMM0070-INFNUM = 'INF' && LS_NR.</font>
        CONCATENATE 'INF' LS_NR INTO LV_INF.
      ENDIF.

      " 채번된 INFCODE WORK AREA에 할당.
      GS_ZTBMM0070-INFNUM = LV_INF.

<font color ="#0000FF">*      "데이터 할당 방법</font>
<font color ="#0000FF">*      " 타임스탬프 WORK AREA에 할당.</font>
<font color ="#0000FF">*      SELECT SINGLE EMPID</font>
<font color ="#0000FF">*       INTO GS_ZTBMM1030-STAMP_USER_F</font>
<font color ="#0000FF">*       FROM ZTBSD1030</font>
<font color ="#0000FF">*       WHERE LOGID = SY-UNAME.</font>
<font color ="#0000FF">*</font>
<font color ="#0000FF">*      GS_ZTBMM1030-STAMP_DATE_F = SY-DATUM.</font>
<font color ="#0000FF">*      GS_ZTBMM1030-STAMP_TIME_F = SY-UZEIT.</font>
<font color ="#0000FF">*</font>

      " 마스터 테이블 TYPE INTERNAL TABLE에 WORK AREA 데이터 할당.

      MODIFY GT_ZTBMM0070 FROM GS_ZTBMM0070 INDEX SY-TABIX.
    ENDLOOP.

    " 마스터 테이블 UPDATE.
    IF SY-SUBRC = 0.
      MODIFY ZTBMM0070 FROM TABLE GT_ZTBMM0070.
      MESSAGE I006 DISPLAY LIKE 'S'.
    ELSE.
      MESSAGE I007 DISPLAY LIKE 'E'.
    ENDIF.

    CLEAR: LS_NR, GS_ZTBMM0070.


  ENDIF.


ENDFORM.
</pre>
<hr>
<font size="2" face = "Sans Serif">Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 754
</font>
</body>
</html>
