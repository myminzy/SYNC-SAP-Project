****************************************************************																																
*   This file was generated by Direct Download Enterprise.     *																																
*   Please do not change it manually.                          *																																
****************************************************************																																
%_DYNPRO																																
ZBRMM0020																																
0120																																
754																																
                40																																
%_HEADER																																
ZBRMM0020                               0120M0120     20 86192 37  0  0 27123  0G E                              20241211141748																																
%_DESCRIPTION																																
120																																
%_FIELDS																																
		CHAR	 85	00	00	00	30	00	  1	  3		  0	  0	  0		 20	R				  0	  0	101									
%#AUTOTEXT001		CHAR	 83	00	00	00	30	00	  2	  4		  0	  0	  0		  6	R				  0	  0	102							결재 상세정보		
ZTBMM0010-PRNUM	0	CHAR	 19	30	00	00	30	00	  3	  5		  0	  0	  0		  0					  0	  0								구매요청번호	                                                                                                                                                                                                                                                        X	
ZTBMM0010-PRNUM	C	CHAR	 14	B0	00	80	30	08	  3	 26		  0	  0	  0		  0					 20	  0								______________	X                                      00	
ZTBMM0010-STATUS	0	CHAR	  8	30	00	01	30	00	  3	 43		  0	  0	  0		  0					  0	  0								결재상태	                                                                                                                                                                                                                                                        X	
STATUS	C	CHAR	 33	80	00	80	32	00	  3	 52		  0	  0	  0		 10					  0	  0								@00@_____________________________		
ZTBMM0010-BPCODE	0	CHAR	 20	30	00	00	30	00	  4	  5		  0	  0	  0		  0					  0	  0								거래처코드	                                                                                                                                                                                                                                                        X	
ZTBMM0010-BPCODE	C	CHAR	 10	A0	00	80	30	00	  4	 26		  0	  0	  0		  0					 20	  0								__________	                                       00	
ZTBMM0010-PRDATE	2	CHAR	 20	30	00	00	30	00	  5	  5		  0	  0	  0		  0					  0	  0								구매요청생성일	                                                                                                                                                                                                                                                        X	
ZTBMM0010-PRDATE	D	DATE	 14	B0	00	80	30	08	  5	 26		  0	  0	  0		  0					 16	  0								______________	X                                      00	
ZTBMM0010-PRNGT	2	CHAR	 20	30	00	00	30	00	  6	  5		  0	  0	  0		  0					  0	  0				MOD				반려사유	                                                                                                                                                                                                                                                        X	
ZTBMM0010-PRNGT	C	CHAR	 30	A0	00	80	30	00	  6	 26		  0	  0	  0		  0					 60	  0				RE				______________________________	                                       00	
CON1			 83	00	00	00	30	00	  8	  4		  0	  0	  0		  6	U				  1	  1	103									
%#AUTOTEXT002		CHAR	 83	00	00	00	30	00	 14	  4		  0	  0	  0		  6	R				  0	  0	104							결재요청 담당자		
ZTBSD1030-EMPNAME	2	CHAR	 20	30	00	00	30	00	 15	  5		  0	  0	  0		  0					  0	  0								사원명	                                                                                                                                                                                                                                                        X	
ZTBSD1030-EMPNAME	C	CHAR	 10	A0	00	80	30	00	 15	 26		  0	  0	  0		  0					 20	  0								__________	                                       00	
ZTBSD1030-DEPCODE	2	CHAR	 20	30	00	04	30	00	 16	  5		  0	  0	  0		  0					  0	  0								부서코드	                                                                                                                                                                                                                                                        X	
ZTBSD1030-DEPCODE	C	CHAR	 10	A0	00	84	30	08	 16	 26		  0	  0	  0		  0					 20	  0								__________	X                                      00	
ZTBSD1030-POSNAME	0	CHAR	 12	30	00	01	30	00	 17	  5		  0	  0	  0		  0					  0	  0								직급명	                                                                                                                                                                                                                                                        X	
ZTBSD1030-POSNAME	C	CHAR	 10	B0	00	81	30	08	 17	 26		  0	  0	  0		  0					 10	  0								__________	X                                      00	
ZTBSD1030-STAMP_DATE_F	2	CHAR	 20	30	00	00	30	00	 18	  5		  0	  0	  0		  0					  0	  0								최초 생성일	                                                                                                                                                                                                                                                        X	
ZTBSD1030-STAMP_DATE_F	D	DATE	 15	B0	00	80	30	08	 18	 26		  0	  0	  0		  0					 16	  0								_______________	X                                      00	
ZTBSD1030-STAMP_TIME_F	T	TIME	 15	B0	00	80	30	08	 18	 42		  0	  0	  0		  0					 12	  0								_______________	X                                      00	
OK_CODE		CHAR	 20	80	10	00	00	00	255	  1	O	  0	  0	  0		  0					  0	  0								____________________		
%_FLOWLOGIC																																
PROCESS BEFORE OUTPUT.																																
  MODULE STATUS_0120.        "STATUS 버튼 세팅																																
																																
  "STATUS BTN SET																																
  MODULE MODIFY_SCREEN_0120. "반려시유 MODIFY_SCREEN = 1																																
																																
  "DATA																																
  MODULE SET_FIELD_0120.																																
  MODULE SET_ALV_0120.																																
																																
  "STATUS																																
  MODULE SET_STATUS_RE_0120. "반려시유 MODIFY_SCREEN = 0																																
																																
  MODULE CLEAR_OK_CODE_0120.																																
																																
PROCESS AFTER INPUT.																																
*-- 입력값 점검																																
*   1.반려사유를 입력하지 않으면 안 되기 때문에 입력값을 점검함.																																
  FIELD ZTBMM0010-PRNGT  MODULE CHECK_RETEXT ON REQUEST.																																
																																
  MODULE EXIT_0120 AT EXIT-COMMAND.																																
  MODULE USER_COMMAND_0120.																																
