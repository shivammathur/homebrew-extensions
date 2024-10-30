class Icu4cAT75 < Formula
  desc "C/C++ and Java libraries for Unicode and globalization"
  homepage "https://icu.unicode.org/home"
  url "https://github.com/unicode-org/icu/releases/download/release-75-1/icu4c-75_1-src.tgz"
  version "75.1"
  sha256 "cb968df3e4d2e87e8b11c49a5d01c787bd13b9545280fc6642f826527618caef"
  license "ICU"

  livecheck do
    url :stable
    regex(/^release[._-]v?(75(?:[.-]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("-", ".") }
    end
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "55042c6a0fb92e96cd620d6550426eba88121760f1ffc26eb88e535eafffdb02"
    sha256 cellar: :any,                 arm64_sonoma:  "a2a2f7ee32720e5365d536d6d0c110d596ffd2e0e9c47b05e13aee3853e3802d"
    sha256 cellar: :any,                 arm64_ventura: "e6fcf7a0d4a9c4ba533e2e325d09742d623841b9c66ac0aaeff853dec98229d0"
    sha256 cellar: :any,                 sonoma:        "26198a2f44a3a179d025608288108480d9bab3b1a8ee53aef0e8469be78ea7a1"
    sha256 cellar: :any,                 ventura:       "4de74b9cdfbf91930651b09a81a67037a1ff571a2a7ef79ab5eb971b3cd6d279"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e7ca9ed261455d9f114079bb46b3175c57265a5e254f9d33404c10a70e5523b5"
  end

  keg_only :shadowed_by_macos, "macOS provides libicucore.dylib (but nothing else)"

  def install
    odie "Major version bumps need a new formula!" if version.major.to_s != name[/@(\d+)$/, 1]

    args = %w[
      --disable-samples
      --disable-tests
      --enable-static
      --with-library-bits=64
    ]

    cd "source" do
      system "./configure", *args, *std_configure_args
      system "make"
      system "make", "install"
    end
  end

  test do
    if File.exist? "/usr/share/dict/words"
      system bin/"gendict", "--uchars", "/usr/share/dict/words", "dict"
    else
      (testpath/"hello").write "hello\nworld\n"
      system bin/"gendict", "--uchars", "hello", "dict"
    end
  end
end
