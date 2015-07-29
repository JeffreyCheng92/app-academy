function Student(first, last){
  this.first = first;
  this.last = last;
  this.courses = [];
}

Student.prototype.name = function (){
  return this.first + " " + this.last;
}

Student.prototype.courses = function (){
  return this.courses; //modify w formating
}

Student.prototype.courseLoad = function () {
  load = {};
  this.courses.forEach(credits)
  function credits (course) {
    if(course.dept in load){
      load[course.dept] += course.num_credits;
    }
    else {
      load[course.dept] = course.num_credits;
    }
  }
  return load;
}

Student.prototype.enroll = function (new_course){
  var enrolled = false
  this.courses.forEach(enroll_check)
  this.courses.forEach(conflict_check)
  if (!enrolled) {
    this.courses.push(new_course);
    new_course.students.push(this);
  }

  function enroll_check (course) {
    if (course === new_course) {
      enrolled = true;
    }
  }

  function conflict_check (course) {
    if (course.conflicts_with(new_course)) {
      throw("conflict in schedule!");
    }
  }
}

function Course(name, dept, num_credits, days, time_block){
  this.name = name;
  this.dept = dept;
  this.num_credits = num_credits;
  this.students = [];
  this.days = days;
  this.time_block = time_block;
}

Course.prototype.add_student = function (student) {
  student.enroll(this);
}

Course.prototype.conflicts_with = function(other_course){
  if ((this.days_conflict(other_course)) &&
        (this.time_block === other_course.time_block)) {
          return true;
      }
  else {
    return false;
  }
}

Course.prototype.days_conflict = function(other_course){
  for (var i = 0; i < this.days.length; i++) {
    for (var j= 0; j < other_course.days.length;j++) {
      if (this.days[i] === other_course.days[j]){
        return true;
      }
    }
  }
  return false;
}

var lisa = new Student("lisa","cho");
var jeff = new Student("jeffrey", "cheng");
var ruby = new Course("Ruby101","cs", 2, ["mon", "wed", "fri"], 5);
var js = new Course("Javascript from hell", "cs", 10, ["wed"], 5);
var writing = new Course("Writing", "arts", 5, ["tues"], 4);
// lisa.enroll(ruby);
// lisa.enroll(js);
// lisa.enroll(writing);
// jeff.enroll(ruby);
