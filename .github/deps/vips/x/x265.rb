class X265 < Formula
  desc "H.265/HEVC encoder"
  homepage "https://bitbucket.org/multicoreware/x265_git"
  url "https://bitbucket.org/multicoreware/x265_git/get/4.0.tar.gz"
  sha256 "66b64be4b316362fdadb33ad8273a74236042cc380691bdbec42946b0437a389"
  license "GPL-2.0-only"
  head "https://bitbucket.org/multicoreware/x265_git.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "d42a6c874641eac96bb6a0c622ac42a2b691659a02c0fa357212eab370dc7c35"
    sha256 cellar: :any,                 arm64_sonoma:  "91a955b8db45ff2818d1eda64e394a132726a9a768d373752c3e02357607dfd5"
    sha256 cellar: :any,                 arm64_ventura: "6b04b6c694c9ff62f54db532f5557601f9ec038e1940a31601728abf49c1a750"
    sha256 cellar: :any,                 sonoma:        "c23fa40a11314b02ab4ad95c079b01445197ebe7cf3a7134469d97ed37fc083f"
    sha256 cellar: :any,                 ventura:       "17f959afb92f42732454bcdc8108eb22583feac30c9d6d0b3b3876a67eebed71"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6048f799a3388953510fc94c6072a3e91098fca293db4a4cec923742f7308fce"
  end

  depends_on "cmake" => :build

  on_intel do
    depends_on "nasm" => :build
  end

  def install
    # Build based off the script at ./build/linux/multilib.sh
    args = std_cmake_args + %W[
      -DLINKED_10BIT=ON
      -DLINKED_12BIT=ON
      -DEXTRA_LINK_FLAGS=-L.
      -DEXTRA_LIB=x265_main10.a;x265_main12.a
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    high_bit_depth_args = std_cmake_args + %w[
      -DHIGH_BIT_DEPTH=ON -DEXPORT_C_API=OFF
      -DENABLE_SHARED=OFF -DENABLE_CLI=OFF
    ]
    (buildpath/"8bit").mkpath

    mkdir "10bit" do
      system "cmake", buildpath/"source", "-DENABLE_HDR10_PLUS=ON", *high_bit_depth_args
      system "make"
      mv "libx265.a", buildpath/"8bit/libx265_main10.a"
    end

    mkdir "12bit" do
      system "cmake", buildpath/"source", "-DMAIN12=ON", *high_bit_depth_args
      system "make"
      mv "libx265.a", buildpath/"8bit/libx265_main12.a"
    end

    cd "8bit" do
      system "cmake", buildpath/"source", *args
      system "make"
      mv "libx265.a", "libx265_main.a"

      if OS.mac?
        system "libtool", "-static", "-o", "libx265.a", "libx265_main.a",
                          "libx265_main10.a", "libx265_main12.a"
      else
        system "ar", "cr", "libx265.a", "libx265_main.a", "libx265_main10.a",
                           "libx265_main12.a"
        system "ranlib", "libx265.a"
      end

      system "make", "install"
    end
  end

  test do
    resource "homebrew-test_video" do
      url "https://raw.githubusercontent.com/fraunhoferhhi/vvenc/master/test/data/RTn23_80x44p15_f15.yuv"
      sha256 "ecd2ef466dd2975f4facc889e0ca128a6bea6645df61493a96d8e7763b6f3ae9"
    end

    resource("homebrew-test_video").stage testpath
    yuv_path = testpath/"RTn23_80x44p15_f15.yuv"
    x265_path = testpath/"x265.265"
    system bin/"x265", "--input-res", "360x640", "--fps", "60", "--input", yuv_path, "-o", x265_path
    header = "AAAAAUABDAH//w=="
    assert_equal header.unpack("m"), [x265_path.read(10)]
  end
end
