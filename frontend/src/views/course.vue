<template>
  <div class="container is-widescreen">
    <section class="section" id="app">
      <div class="content">
        <div class="container">
          <!-- menu-panel -->
          <div class="columns mt-6">
            <div class="column is-one-third">
              <div class="menu">
                <p class="menu-label">ทั่วไป</p>
                <ul class="menu-list">
                  <li><a id="menu-panel" href="/mainPage">หน้าหลัก</a></li>
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
                    <li><a href="/addPost">เพิ่มโพส</a></li>
                    <li><a href="/addCourse">สร้างคอร์สใหม่</a></li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="column is-full">
              <!-- post -->

              <div
                class="columns mt-5"
                v-for="post in posts"
                :key="post.post_id"
              >
                <div class="card has-background-white-ter" style="width: 80%">
                  <div v-if="post.post_image != null" class="card-image">
                    <figure class="image is-4by3 mt-5">
                      <img :src="imagePath(post.post_image)" />
                    </figure>
                  </div>
                  <div class="card-content">
                    <div class="media">
                      <div class="media-left">
                        <figure class="image is-48x48">
                          <img :src="imagePath(post.user_image)" />
                        </figure>
                      </div>
                      <div class="media-content">
                        <p class="title is-4">
                          <b>{{ post.topic }}</b>
                        </p>
                        <p class="subtitle is-6">{{ "@" + post.name }}</p>
                      </div>
                    </div>

                    <div class="content">
                      <div class="title is-4 content" style="margin-left: 15%">
                        {{ post.p_material }}
                      </div>
                      <br />
                      <time>{{
                        "Date: " +
                        post.datetime.substring(0, 10) +
                        " Time: " +
                        post.datetime.substring(11, 19)
                      }}</time>
                      <!-- comment -->
                      <div
                        class="mt-5"
                        v-for="comment in comments"
                        :key="comment.comment_id"
                      >
                        <div
                          class="card-content comment"
                          v-if="comment.post_id == post.post_id"
                        >
                          <div class="media">
                            <div class="media-left">
                              <figure class="image is-48x48">
                                <img :src="imagePath(comment.user_image)" />
                              </figure>
                            </div>
                            <div class="media-content">
                              <p class="title is-4">{{ comment.name }}</p>
                              <p class="subtitle is-6">
                                {{ "@" + comment.name }}
                              </p>
                            </div>
                          </div>

                          <div
                            class="content title is-4"
                            style="margin-left: 15%"
                          >
                            {{ comment.c_material }}
                          </div>
                          <div>
                            <br />
                            <time>{{
                              "Date: " +
                              comment.date.substring(0, 10) +
                              " Time: " +
                              comment.date.substring(11, 19)
                            }}</time>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="columns">
                      <div class="column is-four-fifths">
                        <input
                          type="text"
                          class="input"
                          v-model="newComment[post.post_id]"
                          :id="post.post_id"
                        />
                      </div>
                      <div class="column">
                        <button
                          class="button is-primary"
                          style="margin-top: -15px"
                          @click="comment(post.post_id)"
                        >
                          Send
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>
<script>
import axios from "axios";
// @ is an alias to /src
import { required } from "vuelidate/lib/validators";
export default {
  name: "course",
  props: ["user", "userInfo", "courses"],
  data() {
    return {
      posts: [],
      comments: [],
      newComment: [],
    };
  },
  mounted() {
    this.getPosts(this.$route.params.courseId);
  },
  methods: {
    imagePath(file_path) {
      if (file_path) {
        return "http://localhost:3000/" + file_path;
      } else {
        return "https://bulma.io/images/placeholders/640x360.png";
      }
    },
    getPosts(courseId) {
      axios
        .get(`http://localhost:3000/course/${courseId}`)
        .then((response) => {
          this.posts = response.data.course;
          this.comments = response.data.comment;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    comment(post_id) {
      if (this.newComment[post_id] != undefined) {
        axios
          .post(`http://localhost:3000/comment`, {
            data: this.newComment[post_id],
            post_id: post_id,
            user: this.user,
            userInfo: this.userInfo,
          })
          .then((response) => {
            location.reload();
          })
          .catch((err) => {
            console.log(err);
          });
      } else alert("กรุณาใส่ข้อความแสดงความคิดเห็น");
    },
  },
  validations: {
    newComment: {
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

@keyframes logo {
  0% {
    width: 0;
  }
  100% {
    width: 175px;
  }
}
.content {
  word-break: break-all;
}
.menubar .profile-wrapper {
  position: relative;
  float: right;
  margin-top: -87px;
  right: 10px;
}


.menubar .profile-wrapper .card button {
  border-style: none;
  box-shadow: 0 0 1px black;
  outline: none;
  background-color: white;
}

.menubar .profile-wrapper .card button:hover {
  background-color: #fafafa;
}

.column img {
  width: 50px;
  height: 50px;
  padding-bottom: 0px;
}

.container{
  min-height: 900px;
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
</style>