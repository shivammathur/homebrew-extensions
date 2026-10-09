# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.4.tgz"
  sha256 "41eead0799cc66876b12d10b5efe86268bfc704c1be57a70d49e4bd4bf6c8ee1"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "4bdc245624e49adfbbd8b993efa4b4c50553e9787db07359d8956fc0072b6d23"
    sha256 cellar: :any, arm64_tahoe:       "8a307d4327122f7b7b8bfc5b18c7cd616eef4e42a20a1c5295c17fc07ba4f932"
    sha256 cellar: :any, arm64_sequoia:     "08cdb8ac80a3d5eb451598d92c80655d8e7fca4187024b1416acfdf6bd923261"
    sha256 cellar: :any, arm64_linux:       "ef921750b89987115d852775baf73e38b6c074fc3ad207383ad8ce809dd97756"
    sha256 cellar: :any, x86_64_linux:      "e57da6f15f99b91a6bf5ebca3104a7264d482064434bc7709d737548e6d1be73"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
