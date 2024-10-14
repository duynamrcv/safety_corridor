#pragma once

#include <math.h>
#include <opencv2/core/core.hpp>
#include <opencv2/opencv.hpp>
#include <random>

#include <Eigen/Eigen>

void corridorBuilder2d(float origin_x, float origin_y, float radius,
                       std::vector<Eigen::Vector2f>& data, std::vector<cv::Point2f>& finalVertex,
                       std::vector<Eigen::Vector3f>& outputConstrains);