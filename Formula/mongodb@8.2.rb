# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.7.tgz"
  sha256 "0f46e64139569839b2becd30662a09843ffa9e99b8c4d006b2648a031a10fcc9"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "264c995ac7267938ef0a47b5f42d0b73a4efc1caf93c4a0ace4786b9f9258ea1"
    sha256 cellar: :any,                 arm64_sequoia: "82d25c7553b419d310ab331185309afc2396a64652eb35aa33f9e625e634392d"
    sha256 cellar: :any,                 arm64_sonoma:  "3bfd3f1ef1412b587e8db7b4c61709b5763304d521a46dc3650a7eda878ace18"
    sha256 cellar: :any,                 sonoma:        "b0ebbf65957342f4e613905c7270ce2f1095140226fe6a0668063e523ee00730"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3fe13cdbfe8389773168ec4af9998b5ebcd687d7bf2099e21012eb5aa1731939"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9ca2cc69d354f022055e0944678c4474b2ae251d1467479c2b05d1134a26ff9"
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
