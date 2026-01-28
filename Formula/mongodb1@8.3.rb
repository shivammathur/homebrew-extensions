# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.4.tgz"
  sha256 "ad299dfc4f69859acdb82d7eca5140833370dce31ebbe2c628e716ed3167b841"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "aa98137438622269b0693c35389a00bcbb481b5471dae83ece2621cb4b0c3684"
    sha256 cellar: :any,                 arm64_sequoia: "e409b928c701c4b7c201574631fa6004c679dc313f84d9e39e963638728411c2"
    sha256 cellar: :any,                 arm64_sonoma:  "97340a9214228c9ed5781a050d699614605b2d08d1a26f669aecca7c7e5763f0"
    sha256 cellar: :any,                 sonoma:        "7bd04a2218d0e9eba8a89aaf2faaa3ef969c061e4f7ee3023251644b254d9e64"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ec64037c1069d0fd20e9ef109ac766c3fb9126b1357655cb6a52b6f043d09bbb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "efc1dd675f536fba86b405fa20b8953b1e69563f522d162044a8b27ceeef457c"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
