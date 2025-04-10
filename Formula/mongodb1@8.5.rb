# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "402f1f62e99249233541524f41d7361a89a9f8c1c6fdb10ae7f5a7f65b2daf28"
    sha256 cellar: :any,                 arm64_sonoma:  "bf43a89b597214c5f70851663b72005448ded32a31c9b4de3a1f0a6c046f2eb6"
    sha256 cellar: :any,                 arm64_ventura: "726056dede988324a256dea613f368ede226559c52a925ae30342eca3bd28fc7"
    sha256 cellar: :any,                 ventura:       "ee2f0d764474ed071c2786c5cb59e840ac8ee1c6a0a7eb7cf7160d777240f2dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dc7e6f08a790d87c28b0928c82ba885e3c6bb7edb2e1fe642c141ba4511546f3"
  end

  depends_on "icu4c@77"
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
