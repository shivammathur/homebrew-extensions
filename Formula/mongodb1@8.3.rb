# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "a53162a40b97efb08e510be90a393cdac272a3c182e864f4b35b910aef8b0d4d"
    sha256 cellar: :any,                 arm64_sequoia: "9def72365e873069d4095a228f66bee1d04454c63d7b1f5b0035bcfd8128e7e1"
    sha256 cellar: :any,                 arm64_sonoma:  "33f34daf7c0002c171f7fbed38ffdca5307f402586c10a0869e6b42c07e90e55"
    sha256 cellar: :any,                 sonoma:        "48c9eb0b82b1d23b1635bb5e4dcd6b7eaaae3d62e31528e7f3f72107bb924904"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "66f4d6b90b995d43a7eeb603eac90b30fe8e86edd9e870edd89fdf2791c5783e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2c59edc912ad54c20dfef4489d8023fe2a991dce059c2166919f09e5add9cd1"
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
