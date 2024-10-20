#pragma once

#include <math.h>
#include <opencv2/core/core.hpp>
#include <opencv2/opencv.hpp>
#include <random>

#include <Eigen/Eigen>

class Corridor2d
{
public:
    Corridor2d();
    ~Corridor2d();

    void computeCorridor(const Eigen::Vector2f& pose, const std::vector<Eigen::Vector2f>& data);
    std::vector<Eigen::Vector2f> getCorridorPoints();
    std::vector<Eigen::Vector3f> getCorridorConstraints();

private:
    std::vector<Eigen::Vector2f> vertex_;
    std::vector<Eigen::Vector3f> constraints_;  // (a,b,c) a x + b y <= c
    float radius_;
};