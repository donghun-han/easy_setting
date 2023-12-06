# Dockerfile
## 1. FUEL
### Step
- Modify `CMakeLists.txt` of **bslpline_opt** package
```
find_package(NLopt REQUIRED)
set(NLopt_INCLUDE_DIRS ${NLOPT_INCLUDE_DIR})

...

include_directories( 
    SYSTEM 
    include 
    ${catkin_INCLUDE_DIRS}
    ${Eigen3_INCLUDE_DIRS} 
    ${PCL_INCLUDE_DIRS}
    ${NLOPT_INCLUDE_DIR}
)

...

add_library( bspline_opt 
    src/bspline_optimizer.cpp 
    )
target_link_libraries( bspline_opt
    ${catkin_LIBRARIES} 
    ${NLOPT_LIBRARIES}
    /usr/local/lib/libnlopt.so
    )  

```
- Build
```
catkin_make -DCMAKE_BUILD_TYPE=Release && \
source devel/setup.bash
```
- Launch
```
roslaunch exploration_manager rviz.launch
roslaunch exploration_manager exploration.launch
```