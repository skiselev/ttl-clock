// TTL Clock Stand
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

corner_radius = 2;
$fn = 60;
width=100;
depth=30;
thick=3;
standoff_width=7;
standoff_depth=7;
standoff_height=8;
standoff_angle=8;
hole_diameter=3;

render_stand();

module render_stand() {
    // base plate
    rounded_box(depth,width,thick);
    // standoff 1
    translate([depth/2,0,thick]) {
        standoff(standoff_depth,standoff_width,standoff_height,hole_diameter,standoff_angle);
    }
    // standoff 2
    translate([depth/2,width-standoff_width,thick]) {
        standoff(standoff_depth,standoff_width,standoff_height,hole_diameter,standoff_angle);
    }
}

////////////////////////////////////////////////////////////////////////////////
module standoff(d,w,h,hole,angle)
{
    rotate([0,angle,0]) {
        difference () {
            cube([d,w,h]);
            translate([d/2,w/2,h/2]) {
                rotate([0,90,0]) {
                    cylinder(d=hole,h=d+0.2,center=true);
                }
            }
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
// Rounded Box
module rounded_box(w,l,h,cr=corner_radius)
{
    translate([cr,cr,0]) {
        minkowski() {
            cube([w-cr*2,l-cr*2,h/2]);
            cylinder(r=cr,h=h/2,center=false);
        }
    }
}