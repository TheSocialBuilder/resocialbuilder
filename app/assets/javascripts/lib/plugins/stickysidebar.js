
(function(c) {
    var g = {
        speed: 200,
        easing: "linear",
        padding: 10,
        constrain: !1
    },
        i = c(window),
        e = [],
        l = {
            init: function(a) {
                g = c.extend(g, a);
                return this.each(function() {
                    var a = c(this);
                    m(a);
                    e[e.length] = a;
                    j()
                })
            },
            remove: function() {
                return this.each(function() {
                    var a = this;
                    c.each(e, function(d, b) {
                        if (b.get(0) === a) return k(null, b), e.splice(d, 1), !1
                    })
                })
            },
            destroy: function() {
                c.each(e, function(a, d) {
                    k(null, d)
                });
                e = [];
                i.unbind("scroll", j);
                i.unbind("resize", k);
                return this
            }
        },
        j = function() {
            c.each(e, function(a, d) {
                var b = d.data("stickySB");
                if (b) {
                    var c = i.scrollTop() - b.offs.top;
                    d.offset();
                    var f = b.orig.offset.top - b.offs.top,
                        h = f;
                    f < c && (h = c + g.padding > b.offs.bottom ? b.offs.bottom : c + g.padding);
                    d.stop().animate({
                        top: h
                    }, g.speed, g.easing)
                }
            })
        },
        m = function(a) {
            if (a) {
                var d = a.parent(),
                    b = d.offset(),
                    e = a.offset(),
                    f = a.data("stickySB");
                for (f || (f = {
                    offs: {},
                    orig: {
                        top: a.css("top"),
                        left: a.css("left"),
                        position: a.css("position"),
                        marginTop: a.css("marginTop"),
                        marginLeft: a.css("marginLeft"),
                        offset: a.offset()
                    }
                }); b && "top" in b && d.css("position") == "static";) d = d.parent(), b = d.offset();
                if (b) {
                    var h = parseInt(d.css("paddingBottom")),
                        h = isNaN(h) ? 0 : h;
                    f.offs = b;
                    f.offs.bottom = g.constrain ? Math.abs(d.innerHeight() - h - a.outerHeight()) : c(document).height()
                } else f.offs = {
                    top: 0,
                    left: 0,
                    bottom: c(document).height()
                };
                a.css({
                    position: "absolute",
                    top: Math.floor(e.top - f.offs.top) + "px",
                    left: Math.floor(e.left - f.offs.left) + "px",
                    margin: 0,
                    width: a.width()
                }).data("stickySB", f)
            }
        },
        k = function(a, d) {
            var b = e;
            d && (b = [d]);
            c.each(b, function(a, b) {
                var c = b.data("stickySB");
                c && (b.css({
                    position: c.orig.position,
                    marginTop: c.orig.marginTop,
                    marginLeft: c.orig.marginLeft,
                    left: c.orig.left,
                    top: c.orig.top
                }), d || (m(b), j()))
            })
        };
    i.bind("scroll", j);
    i.bind("resize", k);
    c.fn.stickySidebar = function(a) {
        if (l[a]) return l[a].apply(this, Array.prototype.slice.call(arguments, 1));
        else if (!a || typeof a == "object") return l.init.apply(this, arguments)
    }
})(jQuery); 