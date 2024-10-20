#include "Corridor2d.h"

Corridor2d::Corridor2d()
{
    radius_ = 1000.;
}
Corridor2d::~Corridor2d() {}

void Corridor2d::computeCorridor(const Eigen::Vector2f& pose,
                                 const std::vector<Eigen::Vector2f>& data)
{
    constraints_.clear();
    vertex_.clear();

    float xInterior  = 0.0;
    float yInterior  = 0.0;
    float safeRadius = radius_;
    std::vector<cv::Point2f> flipData(data.size() + 1, cv::Point2f(0, 0));
    for (size_t i = 0; i < data.size(); i++)
    {
        float dx    = data[i].x() - pose.x();
        float dy    = data[i].y() - pose.y();
        float norm2 = std::sqrt(dx * dx + dy * dy);
        if (norm2 < safeRadius) safeRadius = norm2;
        if (norm2 == 0) continue;
        flipData[i].x = dx + 2 * (radius_ - norm2) * dx / norm2;
        flipData[i].y = dy + 2 * (radius_ - norm2) * dy / norm2;
    }

    std::vector<int> vertexIndice;
    cv::convexHull(flipData, vertexIndice, false, false);

    bool isOriginVertex = false;
    int originIndex     = -1;
    std::vector<cv::Point2f> vertexData;
    for (size_t i = 0; i < vertexIndice.size(); i++)
    {
        int v = vertexIndice[i];
        if (v == data.size())
        {
            isOriginVertex = true;
            originIndex    = i;
            vertexData.emplace_back(cv::Point2f(pose.x(), pose.y()));
        }
        else
        {
            vertexData.emplace_back(cv::Point2f(data[v].x(), data[v].y()));
        }
    }

    if (isOriginVertex)
    {
        int lastIndex = (originIndex - 1) % vertexIndice.size();
        int nextIndex = (originIndex + 1) % vertexIndice.size();
        float dx =
            (data[vertexIndice[lastIndex]].x() + pose.x() + data[vertexIndice[nextIndex]].x()) / 3 -
            pose.x();
        float dy =
            (data[vertexIndice[lastIndex]].y() + pose.y() + data[vertexIndice[nextIndex]].y()) / 3 -
            pose.y();
        float d   = std::sqrt(dx * dx + dy * dy);
        xInterior = 0.99 * safeRadius * dx / d + pose.x();
        yInterior = 0.99 * safeRadius * dy / d + pose.y();
    }
    else
    {
        xInterior = pose.x();
        yInterior = pose.y();
    }

    std::vector<int> vIndex2;
    cv::convexHull(vertexData, vIndex2, false, false);  // counterclockwise right-hand

    std::vector<Eigen::Vector3f> constraints;  // (a,b,c) a x + b y <= c
    for (size_t j = 0; j < vIndex2.size(); j++)
    {
        int j1           = (j + 1) % vIndex2.size();
        cv::Point2f rayV = vertexData[vIndex2[j1]] - vertexData[vIndex2[j]];
        Eigen::Vector2f jNormal(rayV.y, -rayV.x);  // point to outside
        jNormal.normalize();
        int jIndex = vIndex2[j];
        while (jIndex != vIndex2[j1])
        {
            float c = (vertexData[jIndex].x - xInterior) * jNormal.x() +
                      (vertexData[jIndex].y - yInterior) * jNormal.y();
            constraints.emplace_back(Eigen::Vector3f(jNormal.x(), jNormal.y(), c));
            jIndex = (jIndex + 1) % vertexData.size();
        }
    }

    std::vector<cv::Point2f> dualPoints(constraints.size(), cv::Point2f(0, 0));
    for (size_t i = 0; i < constraints.size(); i++)
    {
        dualPoints[i].x = constraints[i].x() / constraints[i].z();
        dualPoints[i].y = constraints[i].y() / constraints[i].z();
    }

    std::vector<cv::Point2f> dualVertex;
    cv::convexHull(dualPoints, dualVertex, true, false);

    for (size_t i = 0; i < dualVertex.size(); i++)
    {
        int i1           = (i + 1) % dualVertex.size();
        cv::Point2f rayi = dualVertex[i1] - dualVertex[i];
        float c          = rayi.y * dualVertex[i].x - rayi.x * dualVertex[i].y;
        vertex_.emplace_back(Eigen::Vector2f(xInterior + rayi.y / c, yInterior - rayi.x / c));
    }

    for (size_t i = 0; i < vertex_.size(); i++)
    {
        int i1               = (i + 1) % vertex_.size();
        Eigen::Vector2f rayi = vertex_[i1] - vertex_[i];
        float c              = rayi.y() * vertex_[i].x() - rayi.x() * vertex_[i].y();
        constraints_.emplace_back(Eigen::Vector3f(rayi.y(), -rayi.x(), c));
    }
}

std::vector<Eigen::Vector2f> Corridor2d::getCorridorPoints()
{
    return vertex_;
}

std::vector<Eigen::Vector3f> Corridor2d::getCorridorConstraints()
{
    return constraints_;
}