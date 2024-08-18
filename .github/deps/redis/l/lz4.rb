class Lz4 < Formula
  desc "Extremely Fast Compression algorithm"
  homepage "https://lz4.github.io/lz4/"
  url "https://github.com/lz4/lz4/archive/refs/tags/v1.10.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/lz4-1.10.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/legacy/lz4-1.10.0.tar.gz"
  sha256 "537512904744b35e232912055ccf8ec66d768639ff3abe5788d90d792ec5f48b"
  license "BSD-2-Clause"
  head "https://github.com/lz4/lz4.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "cf10ee811e95f338888acbb57ffaf269f1264ef906f037e045bfe66e97e74d7c"
    sha256 cellar: :any,                 arm64_ventura:  "bf458b5f3ae109a3512a4081708d22933bbbd18536e11641e86de957902dffa7"
    sha256 cellar: :any,                 arm64_monterey: "3aa74a057067672ef332ea751e3e7cbe4364fbc501fdbc797cc4d9ea0425cbb3"
    sha256 cellar: :any,                 sonoma:         "05ee9befaf6fba64f9d0b96779d88dc7137cf126af7daae89177fe6a7743f85b"
    sha256 cellar: :any,                 ventura:        "1eb3faa150917c70c068c53bde3e092b2518b30387075ee61830903e8b53038b"
    sha256 cellar: :any,                 monterey:       "19f209768bc26606e925bff15f01e1af2fa586d3f1014dd124f671d600556896"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb6d36d225948f1089b94de15de8af8a0d9b089c62ba1644e8d9292028939d59"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    input = "testing compression and decompression"
    input_file = testpath/"in"
    input_file.write input
    output_file = testpath/"out"
    system "sh", "-c", "cat #{input_file} | #{bin}/lz4 | #{bin}/lz4 -d > #{output_file}"
    assert_equal output_file.read, input
  end
end
