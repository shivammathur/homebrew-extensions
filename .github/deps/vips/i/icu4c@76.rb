class Icu4cAT76 < Formula
  desc "C/C++ and Java libraries for Unicode and globalization"
  homepage "https://icu.unicode.org/home"
  url "https://github.com/unicode-org/icu/releases/download/release-76-1/icu4c-76_1-src.tgz"
  version "76.1"
  sha256 "dfacb46bfe4747410472ce3e1144bf28a102feeaa4e3875bac9b4c6cf30f4f3e"
  license "ICU"

  # We allow the livecheck to detect new `icu4c` major versions in order to
  # automate version bumps. To make sure PRs are created correctly, we output
  # an error during installation to notify when a new formula is needed.
  livecheck do
    url :stable
    regex(/^release[._-]v?(\d+(?:[.-]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("-", ".") }
    end
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "864ab79f49fd097e8537c281af64e3987d085c753086c60cde74fc84f55ee771"
    sha256 cellar: :any,                 arm64_sonoma:  "2b28efee579ee1a87cb4264e4ea714dd4af6edf59fa2e29955ffe4408428d726"
    sha256 cellar: :any,                 arm64_ventura: "7ca03c808b01c40b270146e476bfcb18367f830e9f1722c9effc4f1c5954b20f"
    sha256 cellar: :any,                 sonoma:        "30d9e64dbac8658ab81012ccfe1e52f87cd1ec8cb247b562d4484665ef6b5247"
    sha256 cellar: :any,                 ventura:       "6d57d5ff7ed6d83916f9c47aa82eb84d1555fc23f8c779491e42e71817d8b2ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a0e8e698c09aee143fce7529fcdf776be98d15f3a000ed8c3e74dc387ce364ac"
  end

  # TODO: Switch keg_only reason after renaming `icu4c` formula to `icu4c@75` and updating alias to `icu4c@76`
  # keg_only :provided_by_macos, "macOS provides libicucore.dylib (but nothing else)"
  keg_only :versioned_formula

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
