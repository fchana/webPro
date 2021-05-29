<template>
  <div class="content">
    <div class="container">
      <!-- menu-panel -->
      <div class="columns mt-6">
        <div class="column is-one-third">
          <div class="menu">
            <p class="menu-label">ทั่วไป</p>
            <ul class="menu-list">
              <li><a href="/mainPage">หน้าหลัก</a></li>
              <li>
                <a id="menu-panel" href="/enrollCourse">เข้าสู่คอร์สใหม่</a>
              </li>
            </ul>
            <p class="menu-label">วิชาทั้งหมดของฉัน</p>
            <ul class="menu-list">
              <li>
                <div v-for="course in courses" :key="course.course_id">
                  <router-link
                    :to="{
                      name: 'course',
                      params: { courseId: course.course_id },
                    }"
                  >
                    <a id="menu-panel">วิชา {{ course.course_name }}</a>
                  </router-link>
                </div>
              </li>
            </ul>
            <div v-if="user.type == 'teacher'">
              <p class="menu-label">ส่วนผู้ดูแล</p>
              <ul class="menu-list">
                <li><a href="/checkStd">เช็คชื่อนักศึกษา</a></li>
                <li><a class="is-active">ลบนักศึกษา</a></li>
                <li><a href="/addStd">เพิ่มนักศึกษา</a></li>
                <li><a href="/addPost">เพิ่มโพส</a></li>
                <li><a href="/addCourse">สร้างคอร์สใหม่</a></li>
              </ul>
            </div>
          </div>
        </div>

        <div class="column">
          <div class="columns">
            <!-- std list -->
            <form class="form-check center">
              <table class="table tcenter">
                <tr>
                  <th>ลำดับที่</th>
                  <th>รหัสนักศึกษา</th>
                  <th>ชื่อจริง</th>
                  <th>นามสกุล</th>
                  <th>ลบ</th>
                </tr>
                <tr v-for="student in studentInCourse" :key="student.enroll_id">
                  <td>{{ student.enroll_id }}</td>
                  <td>{{ student.std_id }}</td>
                  <td>{{ "นาย " + student.fname }}</td>
                  <td>{{ student.lname }}</td>
                  <td>
                    <input
                      type="button"
                      class="button is-danger"
                      value="ลบ"
                      @click="removeStd(student.enroll_id, student.std_id)"
                    />
                  </td>
                </tr>
              </table>
            </form>
          </div>
          <div class="columns">
            <!-- select course-->
            <div class="select course_select center" @change="showStd()">
              <select class="course_select" v-model="selectCourse">
                <option
                  v-for="course in courses"
                  :key="course.course_id"
                  :value="course.course_id"
                >
                  {{ course.course_name }}
                </option>
              </select>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
// @ is an alias to /src
export default {
  name: "mainpage",
  props: ["user", "userInfo", "courses"],
  data() {
    return {
      selectCourse: "",
      studentInCourse: [],
    };
  },
  mounted() {},
  methods: {
    removeStd(enrollId, std_id) {
      const result = confirm("Are you sure you want to delete this student");
      if (result) {
        const data = {
          std_id: std_id,
          courseId: this.selectCourse,
          enrollId: enrollId,
        };
        axios
          .post(`http://localhost:3000/removeStd/`, {
            data,
          })
          .then((response) => {
            alert(response.data);
            location.reload();
          })
          .catch((err) => {
            console.log(err);
          });
      }
    },
    showStd() {
      axios
        .post(`http://localhost:3000/showStd/`, {
          data: this.selectCourse,
        })
        .then((response) => {
          this.studentInCourse = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
};
</script>
<style>
* {
  /* font-family: 'Mitr', sans-serif;
    font-family: 'Roboto Mono', monospace; */
  padding: 0;
  margin: 0;
}

body {
  background-color: white;
}
.column img {
  width: 50px;
  height: 50px;
  padding-bottom: 0px;
}

.columns .id {
  font-size: 22px;
  margin: -15px 0px 0px -20px;
}

.profile-wrapper .card .card-header {
  padding-bottom: 0px;
}

.container{
  min-height: 1000px;
}

.card-header .columns {
  margin: 0px;
}

.card.showProfile {
  position: absolute;
  z-index: 1;
}

.showProfile {
  left: 9px;
  margin-bottom: 0px;
  display: none;
}

.card-content .content {
  overflow-wrap: break-word;
}

.showProfile .card-footer:hover {
  background-color: #fafafa;
}

.column ul,
.column li {
  list-style: none;
}

.comment {
  margin: -15px auto auto;
  width: 95%;
  /* margin-top: -15px; */
  box-shadow: 0 0 1px black;
}

.card-content input {
  margin-top: -15px;
}

/* check std */

.course_select {
  font-size: 18px;
  font-weight: 600;
  margin-top: 5px;
}

.tcenter {
  text-align: center;
}

.form-check {
  text-align: center;
}

.center {
  text-align: center;
  margin-left: auto;
  margin-right: auto;
}
</style>