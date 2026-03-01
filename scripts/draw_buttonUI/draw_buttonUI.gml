function draw_buttonUI(_x, _y, _text)
{
    var w = 200;
    var h = 50;

    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    var hover = point_in_rectangle(mx, my, _x-w/2, _y-h/2, _x+w/2, _y+h/2);

    if (hover)
        draw_set_color(c_gray);
    else
        draw_set_color(c_dkgray);

    draw_rectangle(_x-w/2, _y-h/2, _x+w/2, _y+h/2, false);

    draw_set_color(c_white);
    draw_text(_x, _y, _text);
}