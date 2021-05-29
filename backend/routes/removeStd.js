const { json } = require("express");
const express = require("express");
const pool = require("../config");


const router = express.Router();

router.post('/removeStd', async function (req, res, next) {


    const [[userId]] = await pool.query(
        'SELECT user_id from student where std_id = ? ', [req.body.data.std_id]);

    const [[check]] = await pool.query(
        'SELECT course_id from student_course where user_id = ? and course_id = ?', [userId.user_id, req.body.data.courseId]);

    if (check?.course_id) {
        const conn = await pool.getConnection();
        await conn.beginTransaction();
        try {
            let results = await conn.query(
                "DELETE from student_course where enroll_id = ?", [req.body.data.enrollId]
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
        res.send("ไม่มีนักศึกษาคนนี้อยู่ในระบบ")

});


exports.router = router