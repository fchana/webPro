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
                <li><a class="is-active">เช็คชื่อนักศึกษา</a></li>
                <li><a href="/removeStd">ลบนักศึกษา</a></li>
                <li><a href="/addStd">เพิ่มนักศึกษา</a></li>
                <li><a class="/addPost">เพิ่มโพส</a></li>
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
                  <th>มา / ขาด</th>
                  <th>หมายเหตุ</th>
                </tr>
                <tr>
                  <td>01</td>
                  <td>62xxxxxx</td>
                  <td>นาย ทดสอบ</td>
                  <td>ทดสอบ</td>
                  <td>
                    <input type="checkbox" class="checkbox" name="checkStd" />
                  </td>
                  <td><input type="text" class="input" /></td>
                </tr>
              </table>
            </form>
          </div>
          <div class="columns">
            <!-- check_all button -->
            <div class="column is-one-quarter">
              <input
                type="button"
                value="เช็คทั้งหมด"
                class="button is-success ml-6"
                onclick="check_all()"
              />
            </div>

            <div class="column is-two-fifths">
              <!-- select course-->
              <div class="columns">
                <div class="select course_select center">
                  <select class="course_select">
                    <option value="0">Web Technology</option>
                    <option value="1">Probability statistics</option>
                  </select>
                </div>
              </div>
              <div class="columns">
                <!-- select section -->
                <div class="control mt-4 center">
                  <label class="radio">
                    <input type="radio" name="sec" value="1" checked />
                    Section 1
                  </label>
                  <label class="radio">
                    <input type="radio" name="sec" value="2" />
                    Section 2
                  </label>
                  <label class="radio">
                    <input type="radio" name="sec" value="3" />
                    Section 3
                  </label>
                </div>
              </div>
            </div>
            <!-- check button -->
            <div class="column is-one-third center ml-5">
              <input type="submit" value="เช็ค" class="button is-success" />
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
      search: "",
      lates: [],
    };
  },
  mounted() {
    this.getMain();
  },
  methods: {
    getMain() {
      axios
        .get(`http://localhost:3000/mainPage/`)
        .then((response) => {})
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

.container {
  min-height: 800px;
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

.center {
  text-align: center;
  margin-left: auto;
  margin-right: auto;
}
</style>