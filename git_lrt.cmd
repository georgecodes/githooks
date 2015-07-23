:: git_lrt.cmd v.0.1
:: lubomir i. ivanov (neolit123@gmail.com)
:entry
  @echo off
  echo =================================================
  echo * git_lrt: list files in remote git repository *
  set rdm0=%random%
  set rdm1=%random%
  set lrt_name=git_lrt_%rdm0%_%rdm1%
  set oldcd=%cd%
  set branch=%2
  goto begin
:help
  echo.
  echo     !! WARNING: use at your own risk !!
  echo.
  echo list remote branches with:
  echo    git ls-remote ^<url^>
  echo and then use:
  echo    git_lrt ^<url^> ^<branch^>
  echo    git_lrt ^<url^> ^<branch^> ^> logfile.log
  goto end
:begin
  if not [%1]==[] goto has_repo
  echo ### ERR: no address given
  goto help
:has_repo
  if not [%2]==[] goto has_branch
  echo ### WARN: no branch given. using "master"
  set branch=master
:has_branch
  cd %home%
  if not exist %lrt_name% goto skip_rm
  rm -rf %lrt_name%
:skip_rm
  echo.
  md %lrt_name%
  cd %lrt_name%
  rm -rf *
  git --version
  echo.
  git init
  echo.
  git remote -v add -f %lrt_name% %1
  echo.
  git ls-tree -l -r --full-name --abbrev %lrt_name%/%branch%
  echo.
  echo * clearing %home%/%lrt_name%
  cd..
  rm -rf %lrt_name%
  cd /d %oldcd%
  set rdm0=
  set rdm1=
  set lrt_name=
  set oldcd=
  set branch=
  echo * done
  echo.
:end
