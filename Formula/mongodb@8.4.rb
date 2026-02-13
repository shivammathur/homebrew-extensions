# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.2.1.tgz"
  sha256 "b923617bec3cde420d80bf78aeb05002be3c0e930b93adaacaa5c2e0c25adb42"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e619c703c483559b90dce3bd276e43c09a1a67932b823ac7e9dcf14788128144"
    sha256 cellar: :any,                 arm64_sequoia: "2d12ae579b8eb1cef5991edf202bfde599203764e97aa757452b2058458d6b89"
    sha256 cellar: :any,                 arm64_sonoma:  "a86180a901ad6392dcf0354af588a11f5315f7c36fda6bc7c32a22790cf3ace4"
    sha256 cellar: :any,                 sonoma:        "238b370a5ab262fb430fa34f00a55bd1d7b640c284e5f90ffb6f6b1d5ae6de45"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "962668da0d3ab4484e1140032539e0c8e134e3a0e4cec7b9c202d80f12f60d91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9441e157e8b293f5a2c96ef7f7e819e15f5564cd96e17ed4448ce66ba2a49cc"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
