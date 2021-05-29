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
                <li><a href="/removeStd">ลบนักศึกษา</a></li>
                <li><a class="is-active">เพิ่มนักศึกษา</a></li>
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
                </tr>
                <tr v-for="student in studentInCourse" :key="student.enroll_id">
                  <td>{{ student.enroll_id }}</td>
                  <td>{{ student.std_id }}</td>
                  <td>{{ "นาย " + student.fname }}</td>
                  <td>{{ student.lname }}</td>
                </tr>
                <tr>
                  <td>ลำดับที่</td>
                  <td>
                    <input
                      type="number"
                      class="input"
                      placeholder="รหัสนักศึกษา"
                      style="width: 60%"
                      v-model="$v.addStdId.$model"
                    />
                  </td>
                  <td>ชื่อจริง</td>
                  <td>นามสกุล</td>
                  <td>
                    <input
                      type="button"
                      class="button is-success"
                      value="เพิ่ม"
                      @click="addStd()"
                    />
                  </td>
                </tr>
              </table>
            </form>
          </div>
          <div class="columns" v-if="$v.addStdId.$error">
            <p class="help is-danger center" v-if="!$v.addStdId.required">
              This student number is required
            </p>
            <p class="help is-danger center" v-if="!$v.addStdId.numeric">
              Must be a number
            </p>
            <p class="help is-danger center" v-if="!$v.addStdId.maxLength || !$v.addStdId.minLength">
              Must be 8 character
            </p>
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
import {
  required,
  email,
  minLength,
  maxLength,
  numeric,
  alpha,
} from "vuelidate/lib/validators";
export default {
  name: "mainpage",
  props: ["user", "userInfo", "courses"],
  data() {
    return {
      selectCourse: "",
      studentInCourse: [],
      addStdId: "",
    };
  },
  mounted() {},
  methods: {
    addStd() {
      this.$v.$touch();

      // เช็คว่าในฟอร์มไม่มี error
      if (!this.$v.$invalid && this.selectCourse != "") {
        const data = {
          std_id: this.addStdId,
          courseId: this.selectCourse,
        };
        axios
          .post(`http://localhost:3000/addStd/`, data)
          .then((response) => {
            alert(response.data);
            location.reload();
          })
          .catch((err) => {
            console.log(err);
          });
      } else if (this.selectCourse == "") {
        alert("กรุณาเลือกคอร์ส");
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
  validations: {
    addStdId: {
      required: required,
      numeric: numeric,
      maxLength: maxLength(8),
      minLength: minLength(8)
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

.container{
  min-height: 1000px;
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
