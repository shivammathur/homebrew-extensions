# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.5.tgz"
  sha256 "b542e9285308dcd16ad4277f62a94cca2910ee57616a5a4f576ff686f3da4c77"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d833eade86963a087d981ffca3c18f3871cf29688579cf730d25e2a4ad91fd5c"
    sha256 cellar: :any,                 arm64_sequoia: "4a82b469631b1287e0cb225e7d9d35aefe96f2b1000286fc1850569e198e9f2e"
    sha256 cellar: :any,                 arm64_sonoma:  "86820bb7f26e9f07a1909c1ccfb432f7be0470040bf603d9127af0388f039994"
    sha256 cellar: :any,                 sonoma:        "194fd1889788d1162463b354d4d93d846d0a6ba3ee569743972180c548e0da53"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "50b90c5be2548f6be19461e3b2f03c968b946b96e2661d9da08fabe123a6ed87"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9aeef246ec49dbb4042c84577b59926cbb1f65ad6b12983be7a692cd10888b5a"
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
    inreplace "src/contrib/php_array_api.h", "IS_INTERNED", "ZSTR_IS_INTERNED"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
