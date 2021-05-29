const express = require("express");
const pool = require("../config");
const { isLoggedIn } = require('../middlewares')

router = express.Router();

router.post("/mainPage", async function (req, res) {
    if (req.body.type == "student") {
        try {
            const [[result]] = await pool.query("SELECT max(post_id) post_id, c.course_id FROM course c join post p on c.course_id = p.course_id\
                join student_course sc on c.course_id = sc.course_id   join student s on s.user_id = sc.user_id where s.user_id = ? ", [req.body.user_id]);

            console.log(result)

            const [post] = await pool.query(
                'SELECT p.*, u.user_image FROM post p join user u\
                          on p.user_id = u.user_id WHERE post_id=?', [result.post_id]
            )


            const [comment] = await pool.query(
                'SELECT c.* , u.user_image FROM post p INNER JOIN comment c\
                           ON p.post_id = c.post_id join user u\
                            ON c.user_id = u.user_id WHERE p.post_id = ?', [result.post_id]
            )


            res.json({ post: post, comment: comment })

            return res.send(req.user);
        } catch (err) {
            return res.status(500).json(err);
        };
    }
    else {
        try {
            const [[result]] = await pool.query("SELECT max(post_id) post_id FROM course c join post p on c.course_id = p.course_id\
            join course_teacher ct on c.course_id = ct.course_id  join teacher t on t.user_id = ct.user_id where t.user_id = ? ", [req.body.user_id]);

            console.log(result)

            const [post] = await pool.query(
                'SELECT p.*, u.user_image FROM post p join user u\
                          on p.user_id = u.user_id WHERE post_id=?', [result.post_id]
            )


            const [comment] = await pool.query(
                'SELECT c.* , u.user_image FROM post p INNER JOIN comment c\
                           ON p.post_id = c.post_id join user u\
                            ON c.user_id = u.user_id WHERE p.post_id = ?', [result.post_id]
            )


            res.json({ post: post, comment: comment })

            return res.send(req.user);
        } catch (err) {
            return res.status(500).json(err);
        };
    }

});

exports.router = router;