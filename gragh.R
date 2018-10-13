# 그래프 종류
# 데카르트 방식: plot(x,y)
# 수식기반 방식: plot(x~y)
plot(c(1:5)) #c()는 생략 가능 = plot(1:5)
plot(c(2,2,2,2,2)) 
# 하나면 x는 1씩 증가, y는 벡터의 
plot(1:3,3:1) 
# 두개면 앞 x, 뒤 y
plot(1:3,3:1,xlim = c(1,10), ylim = c(1,5))
# x, y의 값의 리밋값을 설정
plot(1:3,3:1,
     xlim = c(1,10), ylim = c(1,5),
     xlab = 'x축',
     ylab = 'y축',
     main = '테스트'
     )
# type = "p" 점 (디폴트)
# l 선, b 점과 선, c b에서 점 생략
# o 점과 선 중첩, h 점에서 x축까지 수직
# 라인타입
# lty = 0, lty = "blank" 투명선
# lty = 1, lty = "solid" 실선
# lty = 3, lty = "dotted" 점선
# 색깔 col = "red"
# 배경색 = bg = "yellow"
# 선의 굵기 lwd = "2"
# 점이나 문자의 굵기 cex = "3"
target <- round(runif(5,100,150),0)
plot(
  target,
  type = 'o',
  col = 'red',
  ylim = c(0,200),
  axes = F, #hide x, y 축
  ann = F # x, y 축 에 no title
)
axis(
  1, # x축
  at=1:5,
  lab = c('월','화','수','목','금')
)

axis(
  2, # y축 
  ylim = c(0,200)
  )
title(
  main = '과일',
  col.main = 'red',
  font.main = 4
)
title(
  xlab = '요일',
  col.lab = 'black'
)
title(
  ylab = '가격',
  col.lab = 'blue'
)

# multi gragh 
# par(mflow = c(nr,nc))
# nr = number of row
# nc = number of col

target <- round(runif(5,100,150),0)
par(mfrow=c(1,3))
plot(target,type='o') # 선+점
plot(target,type='s') # 계단식
plot(target,type='l') # 꺽은선

target <- round(runif(5,100,150),0)
par(mfrow=c(1,3))
pie(target)
plot(target,type='o')
barplot(target)

par(mfrow=c(1,1))
t1 <- c(1,2,3,4,5)
t2 <- c(5,4,3,2,1)
t3 <- c(3,4,5,6,7)
plot(
  t1, type='s', col='red',ylim = c(1,5)
)
par(new=T) # 중복허용
plot(
  t2, type='o', col='blue',ylim = c(1,5)
)
par(new=T) # 중복허용
plot(
  t3, type='l', col='green'
)

# legend 예제

par(mfrow=c(1,1))
t1 <- c(1,2,3,4,5)
t2 <- c(5,4,3,2,1)
t3 <- c(3,4,5,6,7)
plot(
  t1, type='s', col='red',ylim = c(1,10)
)
lines(
  t2, type='o', col='blue',ylim=c(1,5)
)

lines(
  t2, type='l', col='green',ylim=c(1,15)
)
legend(
  4, #x축의 위치
  9, #y축의 위치
  c("샘플1","샘플2","샘플3"),
  cex = 0.9, #글자크기
  col = c('red','blue','green'),
  lty = 1
)

# 막대그래프
barplot(1:5)
# 수평방향
barplot(1:5,horiz = T)


# 과일판매량 막대그래프로 표현
banana <- round(runif(5,100,150),0)
cherry <- round(runif(5,100,150),0)
orange <- round(runif(5,100,150),0)
fruit <- data.frame(
  바나나 = banana,
  체리 = cherry,
  오렌지 = orange
)
day <- c('월','화','수','목','금')
barplot(
  as.matrix(fruit), ### 반드시 df -> matrix로 전환해서 그려야 함
  main = '과일판매량',
  beside = T,
  col =rainbow(nrow(fruit)),
  ylim = c(0,400)
)
legend(
  14,400,day,cex=0.8,
  fill =rainbow(nrow(fruit))
)

# 과일판매량 막대그래프(2)로 표현
banana <- round(runif(5,100,150),0)
cherry <- round(runif(5,100,150),0)
orange <- round(runif(5,100,150),0)
fruit <- data.frame(
  바나나 = banana,
  체리 = cherry,
  오렌지 = orange
)
day <- c('월','화','수','목','금')
barplot(
  t(fruit), # transform 행과열을 바꿈
  main = '과일판매량',
  col =rainbow(nrow(fruit)),
  ylim = c(0,600),
  space = 0.1,
  cex.axis = 0.8,
  las = 1,
  names.arg = day,
  cex = 0.8
  )
legend(
  0.2,600,names(fruit),cex=0.8,
  fill = rainbow(nrow(fruit))
)

# 오렌지 한 과일의 판매량 보기
ornage <- round(runif(5,100,200),0)
day <- c('월','화','수','목','금')
color <- c()
# for(){} -> ()조건 만큼 {} 실행해라
for(i in c(1:5)){   # i -> 인덱스의 약자
 if(orange[i]>=180){
   color <- c(color,'red')
 }else if(orange[i]>=150){
   color <- c(color,'yellow')
 }else{
   color <- c(color,'green')
 }
}
 barplot(
   orange, # y축
   main = '오렌지판매량',
   col = color,
   ylim = c(0,200),
   names.arg = day # x축
 )
  
  
  
  
































