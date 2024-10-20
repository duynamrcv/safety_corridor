#include <chrono>
#include <fstream>
#include <iostream>
#include "Corridor2d.h"

std::vector<Eigen::Vector2f> generateRandomPoints(int num, float xMax, float yMax)
{
    std::vector<Eigen::Vector2f> data;

    // Define a distribution for floating-point numbers
    std::default_random_engine random(time(NULL));
    std::uniform_real_distribution<float> dist(-1.0, 1.0);  // Random float between 0.0 and 1.0

    float xBound = xMax / 4;
    float yBound = yMax / 4;

    int iter = 0;
    while (iter < num)
    {
        float ax = dist(random) * xMax;
        float ay = dist(random) * yMax;
        if (abs(ax) < xBound && abs(ay) < yBound) continue;
        data.emplace_back(Eigen::Vector2f(ax, ay));
        iter++;
    }
    return data;
}

void saveDataToFiles(const std::string& outDir, const std::vector<Eigen::Vector2f>& points,
                     const std::vector<Eigen::Vector2f>& constrains)
{
    std::ofstream filePoints(outDir + "/points.csv");
    std::ofstream fileCorridor(outDir + "/corridor.csv");

    // Write points
    if (filePoints.is_open())
    {
        filePoints << "x,y\n";  // CSV header
        for (const auto& p : points)
        {
            filePoints << p.x() << "," << p.y() << "\n";
        }
        filePoints.close();
    }

    // Write constaint
    if (fileCorridor.is_open())
    {
        fileCorridor << "cx, cy\n";  // CSV header
        for (const auto& c : constrains)
        {
            fileCorridor << c.x() << "," << c.y() << "\n";
        }
        fileCorridor.close();
    }

    std::cout << "Saved data to " << outDir << std::endl;
}

int main()
{
    std::vector<Eigen::Vector2f> data = generateRandomPoints(200, 50., 1.);

    Corridor2d method;
    Eigen::Vector2f pose(0, 0);

    auto start = std::chrono::high_resolution_clock::now();
    method.computeCorridor(pose, data);
    auto end = std::chrono::high_resolution_clock::now();

    std::chrono::duration<double, std::milli> elapsed = end - start;
    std::cout << "Computation time: " << elapsed.count() << " ms" << std::endl;

    std::vector<Eigen::Vector2f> vertexs     = method.getCorridorPoints();
    std::vector<Eigen::Vector3f> constraints = method.getCorridorConstraints();  // a x + b y <= c;
    saveDataToFiles("data", data, vertexs);

    return 0;
}