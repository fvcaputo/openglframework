CXX = 			g++
CXXFLAGS = 		-I/usr/local/include -O2 -std=c++11 -w
LDFLAGS =		-L/usr/local/lib
LDLIBS =		-lGLEW -framework OpenGL -framework GLUT -lpng

CPP_FILES = main.cpp shader.cpp shape.cpp mathHelper.cpp imageHelper.cpp camera.cpp lighting.cpp screenQuadHelper.h
OBJFILES = main.o shader.o shape.o mathHelper.o imageHelper.o camera.o lighting.o screenQuadHelper.o

main: $(OBJFILES)
	$(CXX) $(CXXFLAGS) -o main $(OBJFILES) $(LDFLAGS) $(LDLIBS)

main.o: main.cpp
	$(CXX) $(CXXFLAGS) -c main.cpp $(LDFLAGS) $(LDLIBS)

shader.o: shader.cpp
	$(CXX) $(CXXFLAGS) -c shader.cpp $(LDFLAGS) $(LDLIBS)

shape.o: shape.cpp
	$(CXX) $(CXXFLAGS) -c shape.cpp $(LDFLAGS) $(LDLIBS)

mathHelper.o: mathHelper.cpp
	$(CXX) $(CXXFLAGS) -c mathHelper.cpp $(LDFLAGS) $(LDLIBS)

imageHelper.o: imageHelper.cpp
	$(CXX) $(CXXFLAGS) -c imageHelper.cpp $(LDFLAGS) $(LDLIBS)

camera.o: camera.cpp
	$(CXX) $(CXXFLAGS) -c camera.cpp $(LDFLAGS) $(LDLIBS)

lighting.o: lighting.cpp
	$(CXX) $(CXXFLAGS) -c lighting.cpp  $(LDFLAGS) $(LDLIBS)

screenQuadHelper.o: screenQuadHelper.cpp
	$(CXX) $(CXXFLAGS) -c screenQuadHelper.cpp  $(LDFLAGS) $(LDLIBS)

# Dependencies

main.o: shader.h shape.h mathHelper.h camera.h screenQuadHelper.h
shader.o: shader.h
shape.o: shape.h
mathHelper.o: mathHelper.h
imageHelper.o: imageHelper.h
camera.o: camera.h
lighting.o: lighting.h
screenQuadHelper.o: screenQuadHelper.h

# Clean

clean:
	rm *.o main
