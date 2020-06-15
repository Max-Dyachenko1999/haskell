module Main where

import           Control.Exception
import           Database.HDBC
import           Database.HDBC.PostgreSQL (connectPostgreSQL)

import           Section
import           Student
import           Teacher

main = do
  c <- connectPostgreSQL "host=localhost dbname=max_dyach user=max_dyach password=password"
  putStrLn " -- TEACHERS -- "
  --
  allTeachers <- readAllTeachers c
  print allTeachers
  newTeacherId <- createTeacher "test" "test" c
  print newTeacherId
  newTeacher <- readTeacher c newTeacherId
  print newTeacher
  updateTeacher newTeacherId "test1" "test1" c
  updatedTeacher <- readTeacher c newTeacherId
  print updatedTeacher
  successfullyDeletedTeacher <- deleteTeacher newTeacherId c
  print successfullyDeletedTeacher
  emptyTeacher <- readTeacher c newTeacherId
  print emptyTeacher
  -- create teacher
  newTeacherId <- createTeacher "test" "test" c
  ---
  putStrLn " -- SECTIONS -- "
  ---
  allSections <- readAllSections c
  print allSections
  newSectionId <- createSection "test" newTeacherId c
  print newSectionId
  newSection <- readSection c newSectionId
  print newSection
  updateSection newSectionId "test1" newTeacherId c
  updatedSection <- readSection c newSectionId
  print updatedSection
  successfullyDeletedSection <- deleteSection newSectionId c
  print successfullyDeletedSection
  emptySection <- readSection c newSectionId
  print emptySection
  -- create section
  newSectionId <- createSection "Neurons" newTeacherId c
  --
  putStrLn " -- STUDENTS -- "
  --
  allStudents <- readAllStudents c
  print allStudents
  newStudentId <- createStudent "test" "test" newSectionId c
  print newStudentId
  newStudent <- readStudent c newStudentId
  print newStudent
  updateStudent newStudentId "test1" "test2" newSectionId c
  updatedStudent <- readStudent c newStudentId
  print updatedStudent
  successfullyDeletedStudent <- deleteStudent newStudentId c
  print successfullyDeletedStudent
  emptyStudent <- readStudent c newStudentId
  print emptyStudent
