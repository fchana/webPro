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
                <li><a href="">เช็คชื่อนักศึกษา</a></li>
                <li><a href="/removeStd">ลบนักศึกษา</a></li>
                <li><a href="/addStd">เพิ่มนักศึกษา</a></li>
                <li><a href="/addPost">เพิ่มโพส</a></li>
                <li><a class="is-active">สร้างคอร์สใหม่</a></li>
              </ul>
            </div>
          </div>
        </div>

        <div class="column">
          <div class="columns">
            <!-- std list -->
            <section class="px-6 center">
              <div class="field mt-5">
                <label class="label"> Name </label>
                <div class="control">
                  <input
                    v-model="$v.course_name.$model"
                    class="input"
                    type="text"
                    placeholder="Text input"
                  />
                </div>
                <template v-if="$v.course_name.$error">
                  <p class="help is-danger" v-if="!$v.course_name.required">
                    This field is required
                  </p>
                </template>
              </div>

              <div class="field">
                <label class="label"> Semester </label>
                <div class="control select">
                  <select v-model="$v.course_semester.$model">
                    <option value="1">1</option>
                    <option value="2">2</option>
                  </select>
                </div>
              </div>
              <template v-if="$v.course_semester.$error">
                <p class="help is-danger" v-if="!$v.course_semester.required">
                  This field is required
                </p>
                <p class="help is-danger" v-if="!$v.course_semester.numeric">
                  Must be a number
                </p>
              </template>
            </section>
          </div>
          <div class="columns">
            <!-- select course-->
            <div class="center">
              <label class="label mt-5"> Password : </label>
              <input
                v-model="$v.course_password.$model"
                class="input"
                type="text"
                placeholder="Text input"
              />
              <template v-if="$v.course_password.$error">
                <p class="help is-danger" v-if="!$v.course_password.required">
                  This field is required
                </p>
                <p class="help is-danger" v-if="!$v.course_password.numeric">
                  Password must be a number
                </p>
                <p class="help is-danger" v-if="!$v.course_password.maxLength">
                  Password must be least than 10 character
                </p>
              </template>
            </div>
          </div>
          <div class="conlumns">
            <div class="field is-grouped">
              <div class="control center">
                <button @click="addCourse" class="button is-link">
                  Submit
                </button>
              </div>
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
import {
  required,
  maxLength,
  numeric,
  alphaNum,
} from "vuelidate/lib/validators";
export default {
  name: "mainpage",
  props: ["user", "userInfo", "courses"],
  data() {
    return {
      course_name: "",
      course_semester: "",
      course_password: "",
    };
  },
  mounted() {},
  methods: {
    addCourse() {
      const data = {
        user: this.user,
        course_name: this.course_name,
        course_semester: this.course_semester,
        course_password: this.course_password,
      };
      axios
        .post(`http://localhost:3000/addCourse/`, { data })
        .then((response) => {
          alert(response.data);
          location.reload();
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
  validations: {
    course_name: {
      required: required,
    },
    course_semester: {
      required: required,
      numeric: numeric,
    },
    course_password: {
      required: required,
      numeric: numeric,
      maxLength: maxLength(10),
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

.container{
  min-height: 1000px;
}

.center {
  text-align: center;
  margin-left: auto;
  margin-right: auto;
}
</style>
