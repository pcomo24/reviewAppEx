//imports
var express = require('express');
var app = express();
const bodyParser = require('body-parser');
var promise = require('bluebird');
var pgp = require('pg-promise')({
    promiseLib: promise
});
//start new database object
var db = pgp({database: 'restaurant_v2'});
//middleware
app.set('view engine', 'hbs');
app.use(bodyParser.urlencoded({ extended: false }));
app.use('/public', express.static('public'));

//urls
app.get('/', function (req, res) {
    res.render('homepage.hbs')
});

app.get('/search',function (req, res, next) {
    //query.searchTerm name matches name on form from homepage.hbs
    var search = req.query.searchTerm;
    //generate based ons search term using ilike operator and % wildcard
    var query = `SELECT * FROM restaurant WHERE restaurant.name ilike '%${search}%'`;
    db.any(query)
        .then(function (resultsArray) {
            res.render('results.hbs', {
                results: resultsArray
            });
            console.log(resultsArray);
        })
        .catch(next);
});
app.get('/restaurant/:id', function (req, res, next) {
    let id = req.params.id;
    var query =
        `SELECT 
            restaurant.id,
            restaurant.name as restaurant_name,
            restaurant.address,
            restaurant.category,
            reviewer.name as reviewer_name,
            review.title,
            review.stars,
            review.review
        FROM 
            restaurant 
        LEFT OUTER JOIN 
            review 
        ON 
            review.restaurant_id = restaurant.id
        LEFT OUTER JOIN 
            reviewer 
        ON 
            review.reviewer_id = reviewer.id
        WHERE 
            restaurant.id = $1`
    ;
    console.log(query);
    db.any(query, id)
        //query produces result
        .then(function (result) {
            console.log('reviews', result)
            //result is passed to object
            var context = {
                restaurant: result[0],
                reviews: result,
                hasReviews: result[0].reviewer_name
            }
            console.log(context);
            res.render('restaurant.hbs', context)
        })
        .catch(next);
});

app.post('/add_review/:id', function (req, res, next) {
    let id = req.params.id;
    var title = req.body.title;
    var stars = req.body.stars;
    var review = req.body.review;
    var reviewInfo = 'INSERT INTO review VALUES (default, NULL, $1, $2, $3, $4)';
    db.result(reviewInfo, [stars, title, review, id])
        .then(function () {
            res.redirect('/')
        })
    .catch(next)
});



app.listen(8000, function () {
    console.log('live on 8000, go head shawty');
});