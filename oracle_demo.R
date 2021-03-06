if("rJava" %in% installed.packages("rJava") == FALSE)install.packages("rJava")
library(rJava)
if("DBI" %in% installed.packages("DBI") == FALSE)install.packages("DBI")
library(DBI)
if("RJDBC" %in% installed.packages("RJDBC") == FALSE)install.packages("RJDBC")
library(RJDBC)
if("XML" %in% installed.packages("XML") == FALSE)install.packages("XML")
library(XML)
if("data.table" %in% installed.packages("data.table") == FALSE)install.packages("data.table")
library(data.table)
#Oracle 데이터를 Rstudio로 가져오는 방법
myJDBC <- JDBC("oracle.jdbc.driver.OracleDriver",
               "C:\\oraclexe\\app\\oracle\\product\\11.2.0\\server\\jdbc\\lib\\ojdbc6.jar")
conn <- dbConnect(myJDBC,
                  "jdbc:oracle:thin:@localhost:1521:xe",
                  "hr",
                  "oracle"
                  )
tab <- dbGetQuery(conn,"SELECT * FROM TAB")
tab
# dplyr
# filter, selectm arrange, mutate,
# summarise, group_by, left_join, bind_rows
tab <- data.frame(tab)
View(tab)
tname <- tab$TNAME
tname <- as.vector(tname)
tname
# [1] "COUNTRIES" cnt       "DEPARTMENTS" dep     "EMPLOYEES" emp      
# [4] "EMP_DETAILS_VIEW" empd   "JOBS"  job           "JOB_HISTORY" jobh    
# [7] "LOCATIONS" loc       "REGIONS" reg   
cnt <- data.frame(dbGetQuery(conn,"SELECT * FROM COUNTRIES"))
head(cnt)
dep <-data.frame(dbGetQuery(conn,"SELECT * FROM DEPARTMENTS"))
head(dep)
emp <- data.frame(dbGetQuery(conn,"SELECT * FROM EMPLOYEES"))
empd <- data.frame(dbGetQuery(conn,"SELECT * FROM EMP_DETAILS_VIEW"))
job <- data.frame(dbGetQuery(conn,"SELECT * FROM JOBS"))
jobh <- data.frame(dbGetQuery(conn,"SELECT * FROM JOB_HISTORY"))
loc <- data.frame(dbGetQuery(conn,"SELECT * FROM LOCATIONS"))
reg <- data.frame(dbGetQuery(conn,"SELECT * FROM REGIONS"))

# cnt의 컬럼명을 한글로 전환하시오.

str(cnt)
# COUNTRY_ID 국가아이디
# COUNTRY_NAME 국가명
# REGION_ID 지역아이디

if("dplyr" %in% installed.packages("dplyr") == FALSE)install.packages("dplyr")
library(dplyr)

cnt <- cnt %>% 
  dplyr::rename(국가아이디 = COUNTRY_ID,
                     국가명 = COUNTRY_NAME,
                     지역아이디 = REGION_ID
                     )
str(cnt)
# dep의 컬럼명 전환
str(dep)
# DEPARTMENT_ID  : 부서아이디
# DEPARTMENT_NAME: 부서명
# MANAGER_ID     : 매니저아이디
# LOCATION_ID    : 위치아이디
# cnt <- cnt %>%
#   dplyr::rename(부서아이디 = DEPARTMENT_ID,
#                      부서명 = DEPARTMENT_NAME,
#                      매니저아이디 = MANAGER_ID,
#                      위치아이디 = LOCATION_ID
#                      )
cnt <- cnt %>% 
  dplyr::rename(부서명 = DEPARTMENT_NAME )

head(dep)
dep <- dep %>% 
  dplyr::rename(부서아이디 = DEPARTMENT_ID,
                     부서명 = DEPARTMENT_NAME,
                     매니저아이디 = MANAGER_ID,
                     위치아이디 = LOCATION_ID)
str(dep)

str(emp)
#######################################################
## emp 의 컬럼명을 한글로 전환하시오.
## 그리고 First Name 과 Last Name 을
## 붙여서 이름 으로 된 컬럼을 추가하시오(참고: P.143)
## 단, 이름 간격은 띄울것. ex) James Dean
## 직원아이디 = EMPLOYEE_ID
## 이메일 = EMAIL
## 전화번호 = PHONE_NUMBER
## 채용일 = HIRE_DATE
## 업무아이디 = JOB_ID
## 연봉 = SALARY
## 커미션비율 = COMMISSION_PCT
## 매니저아이디 = MANAGER_ID
## 부서아이디 = DEPARTMENT_ID
#######################################################

emp <- emp %>%
  dplyr::rename( 직원아이디 = EMPLOYEE_ID,
                이메일 = EMAIL,
                전화번호 = PHONE_NUMBER,
                채용일 = HIRE_DATE,
                업무아이디 = JOB_ID,
                연봉 = SALARY,
                커미션비율 = COMMISSION_PCT,
                매니저아이디 = MANAGER_ID,
                부서아이디 = DEPARTMENT_ID) %>% 
  mutate(이름=paste(FIRST_NAME, LAST_NAME))
View(head(emp))

# 필요없는 변수(행) 삭제하기
emp <- subset(emp,select = -c(FIRST_NAME,LAST_NAME))
View(emp)

# 애달 지급하는 월급여(연봉/12)를 보여주는 월급이라는 컬럼(=변수)을 추가시키시오,
# 0단위 이하는 절삭

str(emp)
emp <- emp %>%
  dplyr::mutate(월급 = 연봉 %/% 12)
emp %>% View


# 연봉이 10000불 이상인 사원(emp)의 목록을 이름, 직원아이디, 연봉만으로 구하되,
# 연봉 내림차순으로 보여주시오.

emp %>%
  left_join(dep, by = "부서아이디") %>%
  filter(연봉 >= 10000) %>% 
  select(이름, 직원아이디, 연봉,부서명) %>% 
  arrange(desc(연봉))

# 연봉이 3000 미만인 사원에게 보너스로 급여의 1%를 지급하겠다고 합니다.
# 대상자의 목록을 이름, 직원아이디, 연봉, 보너스를 기재하고 아이디 오름차순으로 보여주시오.

emp %>%
  filter(연봉<3000) %>%
  mutate(보너스 = 연봉*0.01) %>% 
  select(이름, 직원아이디, 연봉, 보너스) %>% 
  arrange(직원아이디)

# cf. dplyr::mutate > 출처를 표시하고싶으면 dplyr:: 삽입함, 안해도 무관함

# 단, 보너스는 이번 달만 주는 것이므로 emp DF에 저장하지는 말고, 1회용 임시 DF를 따로 생성하여 저장하고, 기한이 지나서는 (보너스 지급 이후) 폐기하라.
보너스지급명세서 <- emp %>% 
  filter(연봉<3000) %>%
  mutate(보너스 = 연봉*0.01) %>% 
  select(이름, 직원아이디, 연봉, 보너스) %>% 
  arrange(직원아이디)
View(보너스지급명세서)
rm(보너스지급명세)

#데이터프레임 이름으로 한글사용은 지속적으로 사용하는 파일에는 위험함.
#rm = remove
#P.149 참고

View(dep)
# 연봉이 10000이 넘는 직원의 부서명, 이름, 연봉을 출력하시오.
emp %>% 
  left_join(dep,by="부서아이디") %>% 
  filter(연봉>= 10000) %>%
  select(부서명, 이름, 연봉)

# 부서별로 연봉 평균을 구하시오.
dep %>% 
  left_join(emp,by="부서아이디") %>% 
  group_by(부서명,부서아이디) %>% 
  dplyr::summarise(연봉평균=mean(연봉,na.rm=T)) %>% 
  arrange(desc(연봉평균)) %>% 
  Veiw

# 이 회사의 부서의 수를 구하시오.
  dep %>% 
    dplyr::distinct(부서명) %>% 
    count()

# 연봉이 12000이 넘는 직원의 부서명, 이름, 연봉, 직책을 기재하시오.
  
  job <- job %>% 
    rename(업무아이디 = JOB_ID,
                직책 = JOB_TITLE,
                최소연봉 = MIN_SALARY,
                최대연봉 = MAX_SALARY
                )
job %>% View
dep %>%
  left_join(emp,by="부서아이디") %>%
  left_join(job, by="업무아이디") %>% 
  filter(연봉>=12000) %>% 
  select(부서명, 이름, 연봉, 직책)

# 부서별로 가장 높은 연봉을 받는 부서아이디, 부서명, 최대연봉을 구하시오.
# max(연봉)

emp %>% 
  left_join(dep,by="부서아이디") %>% 
  left_join(job,by="업무아이디") %>%
  group_by(부서아이디, 부서명) %>% 
  summarise(max(연봉)) %>% 
  View

# 부서아이디를 발급받지 않으면 신입입니다.
# 신입의 이름과 연봉을 구하시오.

View(emp)
emp %>%
  filter(is.na(emp %>% select(부서아이디))) %>%
  select(이름, 연봉, 부서아이디)













