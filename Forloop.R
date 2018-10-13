print(paste("올해는",2016,"년 입니다"))
print(paste("올해는",2017,"년 입니다"))
print(paste("올해는",2018,"년 입니다"))
print(paste("올해는",2019,"년 입니다"))

for(year in c(2016:2019)){
  print(paste("올해는",year,"년 입니다"))
}

# 1~10까지 
# print("숫자 1는 정수 입니다")
# print("숫자 1는 홀수 입니다")
# print("숫자 2는 짝수 입니다")

for ( x in c(1:10)) {
  if(x %% 2 == 1){
    print(paste("숫자",x,"는 홀수 입니다"))
  } else{
    print(paste("숫자",x,"는 짝수 입니다"))
  }
}

# 1부터 10까지의 합을 출력하시오
s <- 0
for (x in 1:10) {
  s <- s+x
}
print(s)

# 1부터 100까지의 짝수의 합과 홀수의 합을 출력하시오.
a <- 0 #홀수
b <- 0 #짝수
for ( x in 1:100) {
  if (x %% 2 == 1) {
    a <- a+x
  } else{
    b <- b+x
  }
}
print(paste("홀수의 합:",a))
print(paste("짝수의 합:",b))





