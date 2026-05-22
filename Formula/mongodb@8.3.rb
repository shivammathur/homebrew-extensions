# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.3.tgz"
  sha256 "370ff9c06932139c69f6b4c57b1a97c95b0278d3baf23fa42b8fb571ddb92bbf"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "160a4e5b962c930932abaa6fc38c59158334396a49ace00629fe8101267b44e8"
    sha256 cellar: :any,                 arm64_sequoia: "91af69ed208c7f88275b24006b00689f8108766c0ee14231e003d35d91010e01"
    sha256 cellar: :any,                 arm64_sonoma:  "c599092f4f5c3866398ac636418c96244e34efad949653d1572ee5c35a70a977"
    sha256 cellar: :any,                 sonoma:        "4fad75b2d546f9d42095e7492401825bee20e43fe7e7ebc16fed08a64d41bc9b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c6d29b5ff12de4ac208a0a27671db14441ff00cce44d49a39e1e874f7523cea6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a37d48468dbf03492b2989985812658a501e6f1f8422d320660999730dfb05aa"
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
