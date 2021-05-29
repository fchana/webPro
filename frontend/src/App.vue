
    <template>
  <div id="app">
    <!-- nav bar -->
    <div class="menubar">
      <!-- logo -->
      <h1 data-text="WHITEBOARD">WHITEBOARD</h1>
      <!-- profile -->
      <div class="profile-wrapper" v-if="user">
        <!-- profile header  -->
        <div class="card profile-header">
          <header class="card-header">
            <div class="columns">
              <div class="column is-one-fifth img">
                <img :src="imagePath(user.user_image)" />
              </div>
              <div class="column id">
                <p class="card-header-title">
                  {{ user.fname + " " + user.lname }}
                </p>
              </div>
            </div>
            <button
              class="card-header-icon"
              style="float: right"
              @click="showProfile()"
            >
              <span class="icon">
                <i class="fas fa-angle-down"></i>
              </span>
            </button>
          </header>
        </div>
        <!-- show profile -->
        <div class="card showProfile">
          <div class="card-content">
            <div class="media">
              <div class="media-left">
                <figure class="image is-48x48">
                  <img :src="imagePath(user.user_image)" />
                </figure>
              </div>
              <div class="media-content">
                <p class="title is-4">{{ user.fname + " " + user.lname }}</p>
                <p v-if="userInfo.type == 'student'" class="subtitle is-6">
                  {{ "User Id " + userInfo.std_id }}
                </p>
              </div>
            </div>
            <div class="content">
              {{ "email : " + user.email }}
              <br />
              {{ "type of user : " + user.type }}
              <span v-if="user.type == 'student'">
                <br />
                {{ "year : " + userInfo.year }}
              </span>
            </div>
          </div>
          <!-- <footer class="card-footer">
            <a href="#" class="card-footer-item">ติดต่อผู้ดูแล</a>
          </footer> -->
          <footer class="card-footer">
            <a class="card-footer-item" @click="logOut">ออกจากระบบ</a>
          </footer>
        </div>
      </div>
    </div>

    <router-view

      :key="$route.fullPath"
      @auth-change="onAuthChange"
      :user="user"
      :userInfo="userInfo"
      :courses="courses"
    />
    <footer class="footer">
      <div class="content has-text-centered">
        <p class="mt-6">
          <strong>WHITEBOARD</strong> by
          <a href="https://www.it.kmitl.ac.th/th/ " target="_blank "
            >IT KMITL.</a
          >
        </p>
      </div>
    </footer>
  </div>
</template>

   <script>
import axios from "@/plugins/axios";

export default {
  data() {
    return {
      user: null,
      userInfo: null,
      courses: null,
    };
  },
  mounted() {
    this.onAuthChange();
  },
  methods: {
    imagePath(file_path) {
      if (file_path) {
        return "http://localhost:3000/" + file_path;
      } else {
        return "https://bulma.io/images/placeholders/640x360.png";
      }
    },
    onAuthChange() {
      const token = localStorage.getItem("token");
      if (token) {
        this.getUser();
      }
    },
    getUser() {
      axios.get("/user/me").then((res) => {
        this.user = res.data.user;
        this.userInfo = res.data.userInfo[0];
        this.courses = res.data.courses;
      });
    },
    showProfile() {
      const check = document.querySelector(".showProfile").style;
      if (check.display == "block") check.display = "none";
      else check.display = "block";
    },
    logOut() {
      localStorage.clear();
      this.user = null;
      window.location.href = "http://localhost:8080/";
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


.menubar {
  width: 100%;
  height: 100px;
  background-color: #fafafa;
  box-shadow: 0 0 1px black;
}

.menubar h1 {
  position: relative;
  left: 50px;
  top: 5px;
  color: #e3e3e3;
  font-size: 60px;
}

.menubar h1::after {
  content: attr(data-text);
  position: absolute;
  left: 0px;
  height: 100%;
  width: 100%;
  color: black;
  text-shadow: 0 0 1px black;
  overflow: hidden;
  animation: logo 5s linear forwards;
}

@keyframes logo {
  0% {
    width: 0;
  }
  100% {
    width: 175px;
  }
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

.columns .id {
  font-size: 22px;
  margin: -15px 0px 0px -20px;
}

.profile-wrapper .card .card-header {
  padding-bottom: 0px;
  width: 100%;
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

.footer {
  clear: both;
  position: relative;
  height: 200px;
  box-shadow: 0 0 1px black;
}
</style>
