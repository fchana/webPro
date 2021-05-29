const express = require("express")
const pool = require("../config")
const Joi = require('joi')
const bcrypt = require('bcrypt');
const { generateToken } = require("../utils/token");
const { isLoggedIn } = require('../middlewares')



router.post('/user/signup', async (req, res, next) => {
    // ...
})

const loginSchema = Joi.object({
    username: Joi.string().required().email(),
    password: Joi.string().required()
})

router.post('/user/login', async (req, res, next) => {
    try {
        await loginSchema.validateAsync(req.body, { abortEarly: false })
    } catch (err) {
        return res.status(400).send("Incorrect username or password")
    }
    const username = req.body.username
    const password = req.body.password

    const conn = await pool.getConnection()
    await conn.beginTransaction()
    try {
        // Check if username is correct
        const [users] = await conn.query(
            'SELECT * FROM user WHERE email=?',
            [username]
        )
        const user = users[0]

        if (!user) {
            throw new Error('Incorrect username or password')
        }

        // Check if password is correct
        if (password != user.password) {
            console.log("password incorrect")
            throw new Error('Incorrect username or password')
        }

        // Check if token already existed
        const [tokens] = await conn.query(
            'SELECT * FROM tokens WHERE user_id=?',
            [user.user_id]
        )
        let token = tokens[0]?.token

        if (!token) {
            // Generate and save token into database
            token = generateToken()
            await conn.query(
                'INSERT INTO tokens(user_id, token) VALUES (?, ?)',
                [user.user_id, token]
            )
        }

        conn.commit()
        res.status(200).json({ 'token': token })
    } catch (error) {
        conn.rollback()
        res.status(400).json("Incorrect username or password")
    } finally {
        conn.release()
    }
})

router.get('/user/me', isLoggedIn, async (req, res, next) => {

    if (req.user.type == "teacher") {
        try {
            const [rows1, fields1] = await pool.query(
                'SELECT * FROM teacher WHERE user_id=?', [req.user.user_id]
            )
            const [courses] = await pool.query(
                'SELECT c.course_id, t.user_id, t.teacher_id, c.course_name from teacher t\
                join course_teacher using (user_id) join course c using(course_id) where t.user_id = ?', [req.user.user_id])
            res.json({ userInfo: rows1, user: req.user, courses: courses })
        } catch (error) {
            res.status(500).json(error)
        }
    }
    else {
        try {
            const [rows1, fields1] = await pool.query(
                'SELECT year, std_id FROM student WHERE user_id=?', [req.user.user_id]
            )
            const [courses] = await pool.query(
                'SELECT c.course_id, course_name, s.user_id, s.std_id from student s join student_course\
                using (user_id) join course c using (course_id) where s.user_id = ?', [req.user.user_id])
            res.json({ userInfo: rows1, user: req.user, courses: courses })
        } catch (error) {
            res.status(500).json(error)
        }
    }
})



exports.router = router