#!/usr/bin/env bash

# @description: check whether number is or not
#方法1：正则表达式
is_number1() {
  if [[ $1 =~ ^[0-9]+$ ]]; then
      echo "Is Number."
  else
      echo "No Number."
  fi
}
# is_number1 "56d"

#方法2：判断是否大于0
is_number2() {
  if [ $1 -gt 0 ] 2>/dev/null; then
      echo "Is Number."
  else
      echo "No Number."
  fi
}

#方法3
is_number3() {
  echo $1 |awk '{print $0~/^[0-9]+$/?"Is Number.":"No Number."}'  #三目运算符
  12.14 找出包含关键字的文件
  DIR=$1
  KEY=$2
  for FILE in $(find $DIR -type f); do
      if grep $KEY $FILE &>/dev/null; then
          echo "--> $FILE"
      fi
  done
}

# @from:  wicked_cool_shell_scripts_2e
#方法4
# validAlphaNum--Ensures that input consists only of alphabetical
#   and numeric characters.
validAlphaNum()
{
  # Validate arg: returns 0 if all upper+lower+digits, 1 otherwise.
  # Remove all unacceptable chars.
  validchars="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"

  if [ "$validchars" = "$1" ] ; then
    return 0
  else
    return 1
  fi
}
# BEGIN MAIN SCRIPT-–DELETE EVERYTHING BELOW THIS LINE IF YOU
#   WANT TO INCLUDE THIS IN OTHER SCRIPTS.
# =================
#/bin/echo -n "Enter input: "
#read input
# Input validation
#if ! validAlphaNum "$input" ; then
#  echo "Your input must consist of only letters and numbers." >&2
#  exit 1
#else
#  echo "Input is valid."
