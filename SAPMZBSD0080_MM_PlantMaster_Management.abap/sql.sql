
<font color ="#0000FF">*  로그인 ID로 사원마스터에 사원ID 가져오기</font>
  SELECT *
    FROM ZTBSD1030
    INTO TABLE GT_ZTBSD1030.

  READ TABLE GT_ZTBSD1030 INTO GS_ZTBSD1030 WITH KEY LOGID = SY-UNAME.
  IF SY-SUBRC = 0.
    EMPID110 = GS_ZTBSD1030-EMPID.
  ENDIF.

MODULE GET_EMP_DATA OUTPUT.
  SELECT SINGLE *
    FROM ZTBSD1030
    WHERE EMPID = GV_EMPID.
<font color ="#0000FF">*    내가 클릭한 ID와 똑같은 한줄만 가져온다.</font>
<font color ="#0000FF">*    INTO가 없는 이유: 이필드가 해당하는 걸 130번에 넣어높음 - 스크린 페이터에 이미</font>
ENDMODULE.


  SELECT *
    FROM ZTBMM1020
    INTO TABLE GT_ZTBMM1020
    WHERE PLTCODE IN RT_PLTCODE
    AND DELFLG LIKE DEL.          "삭제 데이터와 같은~ if 조건을 걸었으니 필터링 같이

    IF SY-SUBRC &lt;&gt; 0.  "조건에 일치하는 데이터가 없는 경우 메세지 출력
      MESSAGE ID 'ZCOMMON_MSG' TYPE 'S' NUMBER '015' DISPLAY LIKE 'E'.
    ENDIF.


    SELECT SINGLE EMPID
      FROM ZTBSD1030
      INTO GV_EMPID
      WHERE LOGID = SY-UNAME.