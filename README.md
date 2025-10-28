# PostgreSQL Docker 실행 및  스크립트 파일 설명

본 프로젝트는 Docker 기반 PostgreSQL 환경에서  
초기 테이블 및 코드 데이터를 자동 세팅하기 위한 스크립트를 포함하고 있습니다.

### 주요 스크립트 파일
| 파일명 | 설명 |
|---------|------|
| `create_table.sql` | 데이터베이스 스키마 및 테이블 생성 스크립트 |
| `insert_code_instance.sql` | 코드/기초 데이터 인스턴스 입력 스크립트 |

---

## PostgreSQL 컨테이너 실행

아래 명령을 실행하여 PostgreSQL 컨테이너를 구동합니다.  
`POSTGRES_USER`, `POSTGRES_PASSWORD`는 환경에 맞게 직접 입력하세요.

```bash
docker run -d   --name mtm-db   -e POSTGRES_USER=<사용자명>   -e POSTGRES_PASSWORD=<비밀번호>   -e TZ=Asia/Seoul   -p 5432:5432   --restart=always   postgres
```




