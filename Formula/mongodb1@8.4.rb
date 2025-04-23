# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  license "Apache-2.0"
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "025d3f2d754c0236c6267a3e32cbbd9db86d47d89a80a1f59263dd691707134c"
    sha256 cellar: :any,                 arm64_sonoma:  "9f26c2070622c824d7ee11f4fdbf2c42ada4bf76b5ce2dff0620b564adfe29b1"
    sha256 cellar: :any,                 arm64_ventura: "4be9e6e828b1ebd8c6375d8cefcc38629f471c2322b101c8f9659e042aa4aade"
    sha256 cellar: :any,                 ventura:       "0cc5f3b6f1f451946aacda47d753c714aa14e0f8debe034d12dbc574262c7e04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e7ee1a0248e1e853ee602572b8a7cd2cb021be09e4f281c30da5deb49e3f9a1e"
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
