<template>
  <div class="container is-widescreen">
    <section class="section" id="app">
      <body>
        <div class="content">
          <div class="container" style="margin-top: 150px">
            <div class="columns">
              <form id="form" class="column is-two-thirds">
                <label class="label">ชื่อผู้ใช้:</label>
                <label class="has-background-danger-light" style="color: red">{{
                  error
                }}</label>
                <input type="text" class="input" v-model="$v.username.$model" />
                <template v-if="$v.username.$error">
                  <p class="help is-danger" v-if="!$v.username.required">
                    This field is required
                  </p>
                  <p class="help is-danger" v-if="!$v.username.minLength">
                    Must be email
                  </p>
                </template>
                <label class="label mt-2">รหัสผ่าน:</label>
                <input
                  type="password"
                  class="input"
                  v-model="$v.password.$model"
                />
                <template v-if="$v.password.$error">
                  <p class="help is-danger" v-if="!$v.password.required">
                    This field is required
                  </p>
                  <p class="help is-danger" v-if="!$v.password.minLength">
                    Must be at least 4 character
                  </p>
                  <p class="help is-danger" v-if="!$v.password.numeric">
                    Must be a number
                  </p>
                </template>
                <br />
                <input
                  @click="submit"
                  class="button is-success is-focused mt-3"
                  value="เข้าสู่ระบบ"
                />
                <router-link
                  :to="{
                    name: 'signup',
                  }"
                >
                  <input
                    class="button is-danger is-focused mt-3 ml-5"
                    value="สมัครสมาชิก"
                  />
                </router-link>
              </form>
              <div class="column">
                <div class="card black">
                  <div class="card-content">
                    <p class="title has-text-centered">
                      <b
                        >WHITEBOARD<br /><br />PROJECT<br /><br />BY<br /><br />ITKMITL</b
                      >
                    </p>
                  </div>
                  <footer class="card-footer">
                    <p class="card-footer-item">
                      <span>
                        View on
                        <a
                          href="https://github.com/fchana/webPro "
                          target="_blank "
                          >GITHUB</a
                        >
                      </span>
                    </p>
                  </footer>
                </div>
              </div>
            </div>
          </div>
        </div>
      </body>
    </section>
  </div>
</template>

<script>
import axios from "@/plugins/axios";
import {
  required,
  email,
  minLength,
  maxLength,
  numeric,
  alpha,
} from "vuelidate/lib/validators";
export default {
  data() {
    return {
      username: "",
      password: "",
      error: "",
    };
  },
  methods: {
    submit() {
      const data = {
        username: this.username,
        password: this.password,
      };

      axios
        .post("http://localhost:3000/user/login/", data)
        .then((res) => {
          const token = res.data.token;
          localStorage.setItem("token", token);
          this.$emit("auth-change");
          this.$router.push({ path: "/mainpage" });
          location.reload();
        })
        .catch((error) => {
          this.error = error.response.data;
          console.log(error.response.data);
        });
    },
  },
  validations: {
    username: {
      required: required,
      email: email,
    },
    password: {
      required: required,
      minLength: minLength(4),
      numeric: numeric,
    },
  },
};
</script>


<style>
.column .black {
  background-color: black;
}

.card {
  height: 400px;
}

.container {
  min-height: 800px;
}

.card-content .title {
  height: 303px;
  padding: 40px;
  font-size: 28px;
  background-color: #fafafa;
}

.card-content .title:hover {
  animation: title 10s linear;
}

.card-footer .card-footer-item {
  background-color: #fafafa;
}
</style>
