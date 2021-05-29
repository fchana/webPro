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
                <li><a href="/addStd">เพิ่มนักศึกษา</a></li>
                <li><a class="is-active">เพิ่มโพส</a></li>
                <li><a href="/addCourse">สร้างคอร์สใหม่</a></li>
              </ul>
            </div>
          </div>
        </div>

        <div class="column">
          <div class="columns">
            <!-- std list -->
            <section class="px-6 center">
              <input
                class="mb-5"
                multiple
                type="file"
                accept="image/png, image/jpeg, image/webp"
                @change="selectImages"
              />

              <div class="field mt-5">
                <label class="label">Title</label>
                <div class="control">
                  <input
                    v-model="$v.title.$model"
                    class="input"
                    type="text"
                    placeholder="Text input"
                  />
                </div>
              </div>
              <template v-if="$v.title.$error">
                <p class="help is-danger" v-if="!$v.title.required">
                  This field is required
                </p>
                <p class="help is-danger" v-if="!$v.title.maxLength">
                  Must be least than 255 character
                </p>
              </template>

              <div class="field">
                <label class="label">Content</label>
                <div class="control">
                  <textarea
                    v-model="$v.content.$model"
                    class="textarea"
                    placeholder="Textarea"
                  ></textarea>
                </div>
              </div>
              <template v-if="$v.content.$error">
                <p class="help is-danger" v-if="!$v.content.required">
                  This field is required
                </p>
                <p class="help is-danger" v-if="!$v.content.maxLength">
                  Must be least than 255 character
                </p>
              </template>
            </section>
          </div>
          <div class="columns">
            <!-- select course-->
            <div class="select course_select center">
              <select class="course_select" v-model="$v.selectCourse.$model">
                <option
                  v-for="course in courses"
                  :key="course.course_id"
                  :value="course.course_id"
                >
                  {{ course.course_name }}
                </option>
              </select>
            </div>
            <template v-if="$v.selectCourse.$error">
              <p class="help is-danger" v-if="!$v.selectCourse.required">
                This field is required
              </p>
            </template>
          </div>
          <div class="conlumns">
            <div class="field is-grouped">
              <div class="control center">
                <button @click="addPost" class="button is-link">Submit</button>
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
import {
  required,
  maxLength,
} from "vuelidate/lib/validators";
// @ is an alias to /src
export default {
  name: "mainpage",
  props: ["user", "userInfo", "courses"],
  data() {
    return {
      title: "",
      selectCourse: "",
      content: "",
      images: "",
    };
  },
  mounted() {},
  methods: {
    selectImages(event) {
      this.images = event.target.files;
    },
    addPost() {
      if (this.selectCourse != "") {
        let formData = new FormData();
        formData.append("user_id", this.user.user_id);
        formData.append("fname", this.user.fname);
        formData.append("type", this.user.type);
        formData.append("title", this.title);
        formData.append("content", this.content);
        formData.append("courseId", this.selectCourse);
        if (this.images != "") {
          this.images.forEach((image) => {
            formData.append("image", image);
          });
          console.log("image");
        } else {
          formData.append("image", "nopic");
          console.log("nopic");
        }
        axios
          .post(`http://localhost:3000/post/`, formData)
          .then((response) => {
            alert(response.data);
            location.reload();
          })
          .catch((err) => {
            console.log(err);
          });
      }
      else if(this.selectCourse == ""){
        alert("กรุณาเลือกคอร์ส")
      }
    },
  },
  validations: {
    title: {
      required: required,
      maxLength: maxLength(255),
    },
    content: {
      required: required,
      maxLength: maxLength(255),
    },
    selectCourse: {
      required: required,
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

.container{
  min-height: 1000px;
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
