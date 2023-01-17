-- ======================================================================
-- 관리자 계정 system
-- ======================================================================
alter session set "_oracle_script" = true;  -- c## 접두어 없이 계정 생성 가능

create user comma
identified by comma
default tablespace users;

alter user comma quota unlimited on users;

grant connect, resource to comma;



-- ======================================================================
-- COMMA 계정
-- ======================================================================

-- ======================================================================
-- 모든 테이블 select
-- ======================================================================
select * from member;
select * from leave_member;
select * from friends;
select * from letter;
select * from attachment_letter;
select * from diary;
select * from design;
select * from font;
select * from complain;
select * from counseling;
select * from attachment_counseling;
select * from cs_comment;
select * from question;
select * from attachment_question;
select * from q_comment;
select * from faq;
select * from chatting;
select * from chatting_member;
select * from chatting_log;



-- ======================================================================
-- 모든 테이블 drop
-- ======================================================================
--drop table member;
--drop table leave_member;
--drop table friends;
--drop table letter;
--drop table attachment_letter;
--drop table diary;
--drop table design;
--drop table font;
--drop table complain;
--drop table counseling;
--drop table attachment_counseling;
--drop table cs_comment;
--drop table question;
--drop table attachment_question;
--drop table q_comment;
--drop table faq;
--drop table chatting;
--drop table chatting_member;
--drop table chatting_log;
--drop sequence seq_friends_no;
--drop sequence seq_letter_no;
--drop sequence seq_attach_letter_no;
--drop sequence seq_diary_no;
--drop sequence seq_design_no;
--drop sequence seq_font_no;
--drop sequence seq_cs_no;
--drop sequence seq_cs_attach_no;
--drop sequence seq_cs_comment_no;
--drop sequence seq_question_no;
--drop sequence seq_q_attach_no;
--drop sequence seq_q_comment_no;
--drop sequence seq_faq_no;
--drop sequence seq_complain_no;
--drop sequence seq_chatting_no;
--drop sequence seq_chatting_member_no;
--drop sequence seq_chatting_log_no;


-- ======================================================================
-- 테이블 생성 (create)
-- ======================================================================
-- member 테이블 생성
create table member(
    member_id varchar2(15),
    nickname varchar2(50) not null,
    password varchar2(300) not null,
    birthday date not null,
    gender char(1) not null,
    phone varchar2(11) not null,
    email varchar2(30) not null,
    enroll_date date default sysdate not null,
    member_role char(1) default 'U' not null,
    warning_count number default 0 not null
);
-- member 제약조건 추가
alter table member
    add constraint pk_member_id primary key (member_id)
    add constraint uq_member_nickname unique (nickname)
    add constraint ck_member_gender check (gender in ('M', 'F'))
    add constraint ck_member_role check (member_role in ('U', 'M', 'A'))
    add constraint ck_warning_count check (warning_count >= 0 and warning_count <= 3);


-- leave_member 테이블 생성
create table leave_member
as
(select m.*, sysdate leave_date from member m);
-- leave_member 제약조건 추가
alter table leave_member
    add constraint pk_leave_member_id primary key (member_id)
    modify leave_date default sysdate;
    

-- friends 테이블 생성
create table friends (
    no number,
    my_nickname varchar2(50),
    f_nickname varchar2(50),
    is_friend char(1) default 'X' not null
);
-- friends 제약조건 추가
alter table friends
    add constraint pk_friends_no primary key (no)
    add constraint fk_friends_my_nickname foreign key (my_nickname) references member(nickname) on delete cascade
    add constraint fk_friends_f_nickname foreign key (f_nickname) references member(nickname) on delete cascade
    add constraint ck_friends_is_friend check (is_friend in ('O', 'X'));

-- seq_friends_no 시퀀스 생성
create sequence seq_friends_no;


-- design 테이블 생성
create table design (
	no number,
	part char(1) not null,
	original_filename varchar2(300),
	renamed_filename varchar2(300),
	reg_date date default sysdate not null
);
-- design 제약조건 추가
alter table design
    add constraint pk_design_no primary key (no)
    add constraint ck_design_part check (part in ('L', 'D'));

-- seq_design_no 시퀀스 생성
create sequence seq_design_no;


-- font 테이블 생성
create table font (
	no number,
	name varchar2(100) not null,
	link varchar2(2000) not null
);
-- font 제약조건 추가
alter table font
    add constraint pk_font_no primary key (no);

-- seq_font_no 시퀀스 생성
create sequence seq_font_no;


-- letter 테이블 생성
create table letter (
	no number,
	writer varchar2(50),
	addressee varchar2(50),
	design_no number not null,
	font_no number not null,
	content clob not null,
	reg_date date default sysdate not null,
	read_check char(1) default 'X' not null,
    limit_gender char(1) default 'X' not null,
    limit_age number default 0 not null
);
-- letter 테이블 제약조건 추가
alter table letter
    add constraint pk_letter_no primary key (no)
    add constraint fk_letter_writer foreign key (writer) references member(nickname) on delete set null
    add constraint fk_letter_addressee foreign key (addressee) references member(nickname) on delete set null
    add constraint fk_letter_design_no foreign key (design_no) references design(no)
    add constraint fk_letter_font_no foreign key (font_no) references font(no)
    add constraint ck_letter_read_check check (read_check in ('O', 'X'))
    add constraint ck_letter_limit_gender check (limit_gender in ('M', 'F', 'X'))
    add constraint ck_letter_limit_age check (limit_age >= 0 and limit_age <= 5);

-- seq_letter_no 시퀀스 생성
create sequence seq_letter_no;
    
-- attachment_letter 테이블 생성
create table attachment_letter (
	no number,
	letter_no number not null,
	original_filename varchar2(300),
	renamed_filename varchar2(300),
	reg_date date	default sysdate not null
);
-- attachment_letter 제약조건 추가
alter table attachment_letter
    add constraint pk_attachment_letter_no primary key (no)
    add constraint fk_attachment_letter_letter_no foreign key (letter_no) references letter(no) on delete cascade;

-- seq_attach_letter_no 시퀀스 생성
create sequence seq_attach_letter_no;


-- diary 테이블 생성
create table diary (
	no number,
	writer varchar2(50),
	design_no number not null,
	font_no number not null,
	content clob not null,
	original_filename varchar2(300),
	renamed_filename varchar2(300),
	reg_date date default sysdate not null
);
-- diary 제약조건 추가
alter table diary
    add constraint pk_diary_no primary key (no)
    add constraint fk_diary_writer foreign key (writer) references member(nickname) on delete cascade
    add constraint fk_diary_design_no foreign key (design_no) references design(no)
    add constraint fk_diary_font_no foreign key (font_no) references font(no);

-- seq_diary_no 시퀀스 생성
create sequence seq_diary_no;


-- counseling 테이블 생성
create table counseling (
	no number,
	writer varchar2(50) not null,
	title varchar2(100) not null,
	content varchar2(4000) not null,
	views number default 0 not null,
	cs_like number default 0 not null,
	category varchar2(15) not null,
	reg_date date default sysdate not null,
    limit_gender char(1) default 'X' not null,
    limit_age numer default 0 not null
);
-- counseling 제약조건 추가
alter table counseling
    add constraint pk_counseling_no primary key (no)
    add constraint fk_counseling_writer foreign key (writer) references member(nickname) on delete cascade
    add constraint ck_counseling_category check (category in ('DAILY', 'CAREER', 'LOVE', 'FRIENDS', 'FAMILY', 'STUDY', 'CHILDCARE'))
    add constraint ck_counseling_limit_gender check (limit_gender in ('M', 'F', 'X'))
    add constraint ck_counseling_limit_age check (limit_age >= 0 and limit_age <= 5);

-- seq_cs_no 시퀀스 생성
create sequence seq_cs_no;

-- attachment_counseling 테이블 생성
create table attachment_counseling (
	no number,
	cs_no number not null,
	original_filename varchar2(300),
	renamed_filename varchar2(300),
	reg_date date default sysdate not null
);
-- attachment_counseling 제약조건 추가
alter table attachment_counseling
    add constraint pk_attachment_counseling_no primary key (no)
    add constraint fk_attachment_countseling_cs_no foreign key (cs_no) references counseling(no) on delete cascade;

-- seq_cs_attach_no 시퀀스 생성
create sequence seq_cs_attach_no;

-- cs_comment 테이블 생성
create table cs_comment (
	no number,
	writer varchar2(50) not null,
	cs_no number not null,
	content varchar2(4000) not null,
	choice char(1) default 'X' not null,
	comment_level char(1) default 'X' not null,
	ref_comment_no number default null,
	reg_date date default sysdate not null
);
-- cs_comment 제약조건 추가
alter table cs_comment
    add constraint pk_cs_comment_no primary key (no)
    add constraint fk_cs_comment_writer foreign key (writer) references member(nickname) on delete cascade
    add constraint fk_cs_comment_cs_no foreign key (cs_no) references counseling(no) on delete cascade
    add constraint ck_cs_comment_choice check (choice in ('O', 'X'))
    add constraint ck_cs_comment_level check (comment_level in ('O', 'X'));

-- seq_cs_comment_no 시퀀스 생성
create sequence seq_cs_comment_no;


-- question 테이블 생성
create table question (
	no number,
	writer varchar2(50) not null,
	title varchar2(100) not null,
	content clob not null,
	reg_date date default sysdate not null
);
-- question 제약조건 추가
alter table question
    add constraint pk_question_no primary key (no)
    add constraint fk_question_writer foreign key (writer) references member(nickname) on delete cascade;

-- seq_question_no 시퀀스 생성
create sequence seq_question_no;

-- attachment_question 테이블 생성
create table attachment_question (
	no number,
	q_no number not null,
	original_filename varchar2(300),
	renamed_filename varchar2(300),
	reg_date date default sysdate not null
);
-- attachment_question 제약조건 추가
alter table attachment_question
    add constraint pk_attachment_question_no primary key (no)
    add constraint fk_attachment_question_q_no foreign key (q_no) references question(no) on delete cascade;

-- seq_q_attach_no 시퀀스 생성
create sequence seq_q_attach_no;

-- q_comment 테이블 생성
create table q_comment (
	no number,
	writer varchar2(50) not null,
	q_no number not null,
	content varchar2(4000) not null,
	reg_date date default sysdate not null
);
-- q_comment 제약조건 추가
alter table q_comment
    add constraint pk_q_comment_no primary key (no)
    add constraint fk_q_comment_writer foreign key (writer) references member(nickname) on delete cascade
    add constraint fk_q_comment_q_no foreign key (q_no) references question(no) on delete cascade;

-- seq_q_comment_no 시퀀스 생성
create sequence seq_q_comment_no;


-- faq 테이블 생성
create table faq(
	no number,
	title varchar2(100) not null,
	content varchar2(4000) not null
);

-- seq_faq_no 시퀀스 생성
create sequence seq_faq_no;


-- complain 테이블 생성
create table complain (
	no number,
	writer varchar2(50) not null,
	villain varchar2(50) not null,
	partition varchar2(15) not null,
	content varchar2(4000) not null,
	partition_no number not null,
	reg_date date default sysdate not null
);
-- complain 제약조건 추가
alter table complain
    add constraint pk_complain_no primary key (no)
    add constraint fk_complain_writer foreign key (writer) references member(nickname) on delete cascade
    add constraint fk_complain_villain foreign key (villain) references member(nickname) on delete cascade
    add constraint ck_complain_partition check (partition in ('LETTER', 'COUNSELING', 'COMMENT', 'CHATTING'));

-- seq_complain_no 시퀀스 생성
create sequence seq_complain_no;


-- chatting 테이블 생성
create table chatting (
    no number,
    name varchar2(100) not null, -- 채팅방 이름
    captin varchar2(50) not null,  -- 방장
    able_gender char(1) not null,
    able_age number not null,
    able_count number not null,
    reg_date date default sysdate
);
-- chatting 제약조건 추가
alter table chatting
    add constraint pk_chatting_no primary key (no)
    add constraint fk_chatting_maker foreign key (captin) references member(nickname) on delete cascade
    add constraint ck_chatting_able_gender check (able_gender in ('M', 'F', 'X'))
    add constraint ck_chatting_able_age check (able_age >= 0 and able_age <= 5);

-- seq_chatting_no 시퀀스 생성
create sequence seq_chatting_no;


-- chatting_member 테이블 생성
create table chatting_member (
    no number,                                          -- 채팅방 별 참여자 테이블 고유 번호
    chat_no number not null,
    nickname varchar2(50) not null,               -- 회원 닉네임
    start_date date default sysdate not null,   -- 채팅방 참여일
    end_date date default null                      -- 채팅방 퇴장일
);
-- chatting_member 제약조건 추가
alter table chatting_member
    add constraint pk_chatting_member_no primary key (no)
    add constraint fk_chatting_member_chat_no foreign key (chat_no) references chatting(no) on delete cascade
    add constraint fk_chatting_member_member foreign key (nickname) references member(nickname) on delete cascade;

-- seq_chatting_member_no 시퀀스 생성
create sequence seq_chatting_member_no;


-- chatting_log 테이블 생성
create table chatting_log (
    no number, -- 채팅로그 별 고유 번호
    chat_no number,
    member_no number,
    which_one char(1) not null,
    content varchar2(1000),
    original_filename varchar2(300),
    renamed_filename varchar2(300),
    reg_date timestamp default systimestamp
);
-- chatting_log 제약조건 추가
alter table chatting_log
    add constraint pk_chatting_log_no primary key (no)
    add constraint fk_chatting_log_chat_no foreign key (chat_no) references chatting(no) on delete cascade
    add constraint fk_chatting_log_member_no foreign key (member_no) references chatting_member(no) on delete cascade
    add constraint ck_chatting_log_which_one check (which_one in ('C', 'F'));

-- seq_chatting_log_no 시퀀스 생성
create sequence seq_chatting_log_no;



-- ======================================================================
-- 트리거 생성 (create)
-- ======================================================================
-- member delete 시 leave_member insert
create or replace trigger trig_member_leave_member
    before
    delete on member
    for each row
begin
    insert into
        leave_member
    values(
        :old.member_id,
        :old.nickname,
        :old.password,
        :old.birthday,
        :old.gender,
        :old.phone,
        :old.email,
        :old.enroll_date,
        :old.member_role,
        :old.warning_count,
        sysdate
    );
end;
/
--drop trigger trig_member_leave_member;


-- member에 warning_count가 3이 되면 member 탈퇴 (에러나서 보류)
create or replace trigger trig_member_warning_count
    before
    update on member
    for each row
begin
    if :new.warning_count = 3 then
        delete from
            member
        where
            member_id = :old.member_id;
    end if;
end;
/
--drop trigger trig_member_warning_count;

--select * from member;
--insert into member values('test', 'test', 'test', '1999-09-09', 'M', '01012341234', 'test@naver.com', default, default, default);
--insert into member values('test1', 'test1', 'test1', '1999-09-09', 'M', '01012341234', 'test1@naver.com', default, default, default);
--update member set warning_count = 2 where member_id = 'test';
--update member set warning_count = 3 where member_id = 'test';

-- ======================================================================
-- TABLE 및 COLUMN 주석
-- ======================================================================
-- member 테이블
comment on table member is '회원관리테이블';
comment on column member.member_id is '회원 아이디(PK, 변경불가)';
comment on column member.nickname is '회원 닉네임(UQ)';
comment on column member.password is '회원 비밀번호(필수입력)';
comment on column member.birthday is '회원 생년월일(필수입력)';
comment on column member.gender is '회원 성별(필수입력)';
comment on column member.phone is '회원 전화번호(필수입력)';
comment on column member.email is '회원 이메일(필수입력)';
comment on column member.enroll_date is '회원가입일';
comment on column member.member_role is '회원권한(CK in (U, M, A))';
comment on column member.friends is '회원친구목록';
comment on column member.warning_count is '누적경고숫자(CK 0 <= count <= 3)';

-- leave_member 테이블
comment on table leave_member is '탈퇴회원관리테이블';
comment on column leave_member.member_id is '탈퇴회원아이디(PK, 변경불가)';
comment on column leave_member.nickname is '탈퇴회원닉네임(UQ)';
comment on column leave_member.password is '탈퇴회원비밀번호(필수입력)';
comment on column leave_member.birthday is '탈퇴회원생년월일(필수입력)';
comment on column leave_member.gender is '탈퇴회원성별(필수입력)';
comment on column leave_member.phone is '탈퇴회원전화번호(필수입력)';
comment on column leave_member.email is '탈퇴회원이메일(필수입력)';
comment on column leave_member.enroll_date is '탈퇴회원가입일';
comment on column leave_member.member_role is '탈퇴회원권한';
comment on column leave_member.friends is '탈퇴회원친구목록';
comment on column leave_member.warning_count is '탈퇴누적경고숫자';
comment on column leave_member.leave_date is '회원탈퇴일';

-- friends 테이블
comment on table friends is '친구관리테이블';
comment on column friends.no is '친구 관리 번호(PK, 변경불가)';
comment on column friends.my_nickname is '회원닉네임(FK member.nickname on delete cascade)';
comment on column friends.f_nickname is '친구닉네임(FK member.nickname on delete cascade)';
comment on column friends.is_friend is '친구여부(CK in (O, X))';

-- letter 테이블
comment on table letter is '편지테이블';
comment on column letter.no is '편지 번호(PK, 변경불가)';
comment on column letter.writer is '편지 발신인(FK member.nickname on delete set null)';
comment on column letter.addressee is '편지 수신인(FK member.nickname on delete set null)';
comment on column letter.design_no is '편지선택디자인(FK design.no)';
comment on column letter.font_no is '편지선택폰트(FK font.no)';
comment on column letter.content is '편지 내용(필수입력)';
comment on column letter.reg_date is '편지 작성일';
comment on column letter.read_check is '편지수신여부(CK in (O, X))';
comment on column letter.limit_gender is '편지 수신인 성별 선택(CK in (M, F, X))';
comment on column letter.limit_age is '편지 수신인 연령 선택(CK 0 <= age <= 5)';

-- attachment_letter 테이블
comment on table attachment_letter is '편지첨부파일테이블';
comment on column attachment_letter.no is '편지 첨부파일번호(PK, 변경불가)';
comment on column attachment_letter.letter_no is '참조한 편지번호(FK letter.no on delete cascade)';
comment on column attachment_letter.original_filename is '업로드한 편지첨부파일명';
comment on column attachment_letter.renamed_filename is '저장된 편지첨부파일명';
comment on column attachment_letter.reg_date is '편지 첨부파일 등록일';

-- diary 테이블
comment on table diary is '일기장테이블';
comment on column diary.no is '일기장 번호(PK, 변경불가)';
comment on column diary.writer is '일기 작성자(FK member.nickname on delete cascade)';
comment on column diary.design_no is '일기장선택디자인(FK design.no)';
comment on column diary.font_no is '일기장선택폰트(FK font.no)';
comment on column diary.content is '일기장 내용(필수입력)';
comment on column diary.original_filename is '업로드한 일기장첨부파일명';
comment on column diary.renamed_filename is '저장된 일기장첨부파일명';
comment on column diary.reg_date is '일기장 작성한 날짜';

-- design 테이블
comment on table design is '디자인테이블';
comment on column design.no is '디자인 번호(PK, 변경불가)';
comment on column design.part is '디자인 분류기호(CK in (L, D))';
comment on column design.original_filename is '업로드한 디자인첨부파일명';
comment on column design.renamed_filename is '저장된 디자인첨부파일명';
comment on column design.reg_date is '디자인 등록일';

-- font 테이블
comment on table font is '폰트테이블';
comment on column font.no is '폰트 번호(PK, 변경불가)';
comment on column font.name is '폰트 이름(필수입력)';
comment on column font.link is '폰트 링크(필수입력)';

-- counseling 테이블
comment on table counseling is '고민상담소테이블';
comment on column counseling.no is '고민글 번호(PK, 변경불가)';
comment on column counseling.writer is '고민글 작성자(FK member.nickname on delete cascade)';
comment on column counseling.title is '고민글 제목(필수입력)';
comment on column counseling.content is '고민글 내용(필수입력)';
comment on column counseling.views is '고민글 조회 수';
comment on column counseling.cs_like is '고민글 추천 수';
comment on column counseling.category is '고민글 카테고리(CK in (DAILY, CAREER, LOVE, FRIENDS, FAMILY, STUDY, CHILDCARE))';
comment on column counseling.reg_date is '고민글 작성한 날짜';
comment on column counseling.limit_gender is '고민글 조회자 성별 제한(CK in (M, F, X))';
comment on column counseling.limit_age is '고민글 조회자 연령 제한(CK 0 <= age <= 5)';

-- attachment_counseling 테이블
comment on table attachment_counseling is '고민상담소 첨부파일테이블';
comment on column attachment_counseling.no is '고민상담소 첨부파일번호(PK, 변경불가)';
comment on column attachment_counseling.cs_no is '참조한 고민글번호(FK counseling.no on delete cascade)';
comment on column attachment_counseling.original_filename is '업로드한 고민글첨부파일명';
comment on column attachment_counseling.renamed_filename is '저장된 고민글첨부파일명';
comment on column attachment_counseling.reg_date is '고민글 첨부파일 등록일';

-- cs_comment 테이블
comment on table cs_comment is '고민상담소 댓글테이블';
comment on column cs_comment.no is '고민상담소 댓글번호(PK, 변경불가)';
comment on column cs_comment.writer is '고민글 댓글 작성자(FK member.nickname on delete cascade)';
comment on column cs_comment.cs_no is '참조한 고민글 번호(FK counseling.no on delete cascade)';
comment on column cs_comment.content is '고민글 댓글 내용(필수입력)';
comment on column cs_comment.choice is '고민글 작성자가 채택한 댓글 여부(CK in (O, X))';
comment on column cs_comment.comment_level is '댓글 및 대댓글 여부(CK in (O, X))';
comment on column cs_comment.ref_comment_no is '참조한 댓글 번호(대댓글인 경우)';
comment on column cs_comment.reg_date is '고민글 댓글 작성일';

-- question 테이블
comment on table question is '문의게시판테이블';
comment on column question.no is '문의글 번호(PK, 변경불가)';
comment on column question.writer is '문의글 작성자(FK member.nickname)';
comment on column question.title is '문의글 제목(필수입력)';
comment on column question.content is '문의 내용(필수입력)';
comment on column question.reg_date is '문의글 작성일';

-- attachment_question 테이블
comment on table attachment_question is '문의게시판 첨부파일테이블';
comment on column attachment_question.no is '문의게시판 첨부파일번호(PK, 변경불가)';
comment on column attachment_question.q_no is '참조한 문의게시판번호(FK question.no on delete cascade)';
comment on column attachment_question.original_filename is '업로드한 문의글첨부파일명';
comment on column attachment_question.renamed_filename is '저장된 문의글첨부파일명';
comment on column attachment_question.reg_date is '문의게시판 첨부파일 등록일';

-- q_comment 테이블
comment on table q_comment is '문의게시판 댓글테이블';
comment on column q_comment.no is '문의게시판 댓글번호(PK, 변경불가)';
comment on column q_comment.writer is '문의게시판 댓글 작성자(FK member.nickname on delete cascade)';
comment on column q_comment.q_no is '참조한 문의게시판번호(FK question.no on delete cascade)';
comment on column q_comment.content is '문의게시판 댓글 내용(필수입력)';
comment on column q_comment.reg_date is '문의게시판 댓글 작성일';

-- faq 테이블
comment on table faq is '자주묻는 질의응답 테이블';
comment on column faq.no is '자주묻는 질의응답 번호(PK, 변경불가)';
comment on column faq.title is '자주묻는 질의응답 제목(필수입력)';
comment on column faq.content is '자주묻는 질의응답 내용(필수입력)';

-- complain 테이블
comment on table complain is '신고 테이블';
comment on column complain.no is '신고 번호(PK, 변경불가)';
comment on column complain.writer is '신고자(FK member.nickname on delete cascade)';
comment on column complain.villain is '피신고자(FK member.nickname on delete cascade)';
comment on column complain.partition is '신고 분류 문자(CK in (LETTER, COUNSELING, COMMENT, CATTING))';
comment on column complain.content is '신고 내용(필수 입력)';
comment on column complain.partition_no is '신고 분류 번호(편지, 고민상담소, 댓글, 채팅의 no)';
comment on column complain.reg_date is '신고일';

-- chatting 테이블
comment on table chatting is '채팅방 테이블';
comment on column chatting.no is '채팅방 번호(PK, 변경불가)';
comment on column chatting.name is '채팅방 이름(필수입력)';
comment on column chatting.captin is '채팅방 방장(FK member.nickname on delete cascade)';
comment on column chatting.able_gender is '채팅방 참여 가능 성별(CK in (M, F, X))';
comment on column chatting.able_age is '채팅방 참여 가능 연령(CK 0 <= age <= 5)';
comment on column chatting.able_count is '채팅방 참여 가능 인원';
comment on column chatting.reg_date is '채팅방 생성일';

-- chatting_member 테이블
comment on table chatting_member is '채팅 참여자 테이블';
comment on column chatting_member.no is '채팅 참여자 번호(PK, 변경불가)';
comment on column chatting_member.chat_no is '채팅방 참조 번호(FK chatting.no on delete cascade)';
comment on column chatting_member.nickname is '채팅방 참여자 닉네임(FK member.nickname on delete cascade)';
comment on column chatting_member.start_date is '채팅방 참여 시작일';
comment on column chatting_member.end_date is '채팅방 퇴장일';

-- chatting_log 테이블
comment on table chatting_log is '채팅로그 테이블';
comment on column chatting_log.no is '채팅로그 번호 테이블(PK, 변경불가)';
comment on column chatting_log.chat_no is '참여 채팅방 번호(FK chatting.no on delete cascade)';
comment on column chatting_log.member_no is '채팅 작성자(FK member.nickname on delete cascade)';
comment on column chatting_log.which_one is '채팅로그 구분(CK in (C, F))';
comment on column chatting_log.content is '채팅 내용';
comment on column chatting_log.original_filename is '채팅 첨부파일 원본명';
comment on column chatting_log.renamed_filename is '채팅 첨부파일 저장명';
comment on column chatting_log.reg_date is '채팅시간';
