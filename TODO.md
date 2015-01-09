# TODO items

## Make helper methods like getBy, getAll, etc. operate truly static.

Currently they create an instance internally because the library was initially designed to support PHP 5.2, which doesn't support late static binding. There is probably also a debate to be had as to whether getFields should be static or not. Hence this kind of code in Post.php:

    $instance = Post\Factory::create(get_called_class());


## Add Post Interface