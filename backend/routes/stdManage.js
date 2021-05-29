const { json } = require("express");
const express = require("express");
const pool = require("../config");
const Joi = require('joi')

const addStdSchema = Joi.object({
  std_id: Joi.string().pattern(/[0-9]/).required(),
  courseId: Joi.number().required()
})


const router = express.Router();

router.post('/addStd', async function (req, res, next) {
    try {
        await addStdSchema.validateAsync(req.body, { abortEarly: false })
    } catch (err) {
        return res.status(400).send("Incorrect std_id or courseId")
    }
    const [[userId]] = await pool.query(
        'SELECT user_id from student where std_id = ? ', [req.body.std_id]);

    const [[check]] = await pool.query(
        'SELECT course_id from student_course where user_id = ? and course_id = ?', [userId.user_id, req.body.courseId]);

    if (!check?.course_id) {
        const conn = await pool.getConnection();
        await conn.beginTransaction();
        try {
            let results = await conn.query(
                "INSERT INTO student_course(user_id, date, course_id) " +
                "VALUES(?, CURRENT_TIMESTAMP, ?);",
                [userId.user_id, req.body.courseId]
            );

            await conn.commit();
            res.send("success!");
        } catch (err) {
            await conn.rollback();
            return res.status(400).json(err);
        } finally {
            conn.release();
        }
    }
    else
        res.send("มีนักศึกษาคนนี้อยู่ในระบบแล้ว")

});


exports.router = router