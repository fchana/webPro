import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [{
        path: '/',
        name: 'login',
        meta: { guess: true },
        component: () =>
            import ('../views/login.vue')
    },
    {
        path: '/mainpage',
        name: 'mainapge',
        meta: { login: true },
        component: () =>
            import ('../views/main.vue')
    },
    {
        path: '/removeStd',
        name: 'removeStd',
        meta: { login: true },
        component: () =>
            import ('../views/removeStd.vue')
    },
    {
        path: '/checkStd',
        name: 'checkStd',
        meta: { login: true },
        component: () =>
            import ('../views/checkStd.vue')
    },
    {
        path: '/addStd',
        name: 'addStd',
        meta: { login: true },
        component: () =>
            import ('../views/addStd.vue')
    },
    {
        path: '/course/:courseId',
        name: 'course',
        meta: { login: true },
        component: () =>
            import ('../views/course.vue')
    },
    {
        path: '/addPost',
        name: 'addPost',
        meta: { login: true },
        component: () =>
            import ('../views/addPost.vue')
    },
    {
        path: '/addCourse',
        name: 'addCourse',
        meta: { login: true },
        component: () =>
            import ('../views/addCourse.vue')
    },
    {
        path: '/enrollCourse',
        name: 'enrollCourse',
        meta: { login: true },
        component: () =>
            import ('../views/enrollCourse.vue')
    },
    {
        path: '/signup',
        name: 'signup',
        meta: { guess: true },
        component: () =>
            import ('../views/signup.vue')
    },
]

const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
})
 router.beforeEach((to, from, next) => {
   const isLoggedIn = !!localStorage.getItem('token')
 
   if (to.meta.login && !isLoggedIn) {
     alert('Please login first!')
     next({ path: '/' })
   }
 
   if (to.meta.guess && isLoggedIn) {
     next({ path: '/mainpage'})
   }
 
   next()
 })

export default router