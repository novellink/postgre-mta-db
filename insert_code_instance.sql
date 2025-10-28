/*
 * 현재 사용중이 code_type 인스턴스 생성 
 */

INSERT INTO public.code_type
(id, "name")
VALUES
(100,'헬스 데이터 타입'),
(200, '측정 타입'),
(300, '공급자 타입'),
(400, '로그 타입(회원 상태)');


/*
 * code 헬스 데이터 타입 인스턴스 생성
 */

INSERT INTO public.code
(id, "name", type_id)
VALUES
(101, '혈압(BP)', 100),
(102, '신장체중(HS)', 100),
(103, '시력(VA)', 100),
(104, '색각(CM)', 100),
(105, '체성분(BC)', 100),
(106, '혈당(BS)', 100),
(107, '자율신경계_접촉식(ST)', 100),
(108, '음주(AL)', 100),
(109, '폐활량(LU)', 100),
(110, 'HRV', 100);


/*
 * code 측정 타입 인스턴스 생성
 */

INSERT INTO public.code
(id, "name", type_id)
VALUES
(201, '블루투스(BT)', 200),
(202, '수기(WT)', 200),
(203, 'MTM', 200);


/*
 * code 공급자 타입 인스턴스 생성
 */

INSERT INTO public.code
(id, "name", type_id)
VALUES
(301, '네이버', 300),
(302, '카카오', 300),
(303, '구글', 300),
(304, '애플', 300);


/*
 * code 로그 타입 인스턴스 생성
 */

INSERT INTO public.code
(id, "name", type_id)
VALUES
(401, '정상', 400),
(402, '휴면', 400),
(403, '탈퇴', 400),
(404, '삭제', 400);




