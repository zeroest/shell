#!/bin/bash
# cleanup, version 2
# 루트로 실행시키세요.

LOG_DIR=/var/log
ROOT_UID=0     # $UID가 0인 유저만이 루트 권한을 갖습니다.
LINES=50       # 기본적으로 저장할 줄 수.
E_XCD=66       # 디렉토리를 바꿀 수 없다?
E_NOTROOT=67   # 루트가 아닐 경우의 종료 에러.


if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "이 스크립트는 루트로 실행시켜야 됩니다."
  exit $E_NOTROOT
fi  

if [ -n "$1" ]
# 명령어줄 인자가 존재하는지 테스트(non-empty).
then
  lines=$1
else  
  lines=$LINES # 명령어줄에서 주어지지 않았다면 디폴트값을 씀.
fi  


#  Stephane Chazelas 가 명령어줄 인자를 확인하는 더 좋은 방법을
#+ 제안해 주었는데 지금 단계에서는 약간 어려운 주젭니다.
#
#    E_WRONGARGS=65  # 숫자가 아닌 인자.(틀린 인자 포맷)
#
#    case "$1" in
#    ""      ) lines=50;;
#    *[!0-9]*) echo "사용법: `basename $0` 정리할파일"; exit $E_WRONGARGS;;
#    *       ) lines=$1;;
#    esac
#
#* 이것을 이해하려면 "루프" 절을 참고하세요.


cd $LOG_DIR

if [ `pwd` != "$LOG_DIR" ]  # 혹은    if [ "$PWD" != "LOG_DIR" ]
                            # /var/log 에 있지 않다?
then
  echo "$LOG_DIR 로 옮겨갈 수 없습니다."
  exit $E_XCD
fi  # 로그파일이 뒤죽박죽되기 전에 올바른 디렉토리에 있는지 두번 확인함.

# 더 좋은 방법은:
# ---
# cd /var/log || {
#   echo "필요한 디렉토리로 옮겨갈 수 없습니다." >&2
#   exit $E_XCD;
# }




tail -$lines messages > mesg.temp # message 로그 파일의 마지막 부분을 저장.
mv mesg.temp messages             # 새 로그 파일이 됨.


# cat /dev/null > messages
#* 위의 방법이 더 안전하니까 필요 없음.

cat /dev/null > wtmp  # > wtemp   라고 해도 같은 결과.
echo "로그가 정리됐습니다."

exit 0
#  스크립트 종료시에 0을 리턴하면
#+ 쉘에게 성공했다고 알려줌.
