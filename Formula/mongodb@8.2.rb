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
    sha256 cellar: :any,                 arm64_tahoe:   "da173a43b48349eea32390ca3d0d95cd8c3b0dadbe2e2f45e1fc89956bd62624"
    sha256 cellar: :any,                 arm64_sequoia: "575e17b9063484d7c2be9004d5ded02bb76e194906ae64e4eebf9e3d6d89f34b"
    sha256 cellar: :any,                 arm64_sonoma:  "9588c38282f65f47e94bde071d87d758e1a34ab5d7b9a8f9f0cf374a952cb30e"
    sha256 cellar: :any,                 sonoma:        "8e05dc1a259e6dc8b89543a88daca42a272f7ae23a32eefb8e058dcd2a8d99e9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fbbcfc4d44f3d3cfb87c8233c5160b10cbb9d35c67e2d88c16b47bb71389e816"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3d06b8b0a14b79e401340e8b54111f735372cb510f5a2c6aa9c02cc5e471b513"
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
