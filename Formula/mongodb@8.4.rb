# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.1.tgz"
  sha256 "2738972432d36c370fde3c76c208c31bd5a7a0afc4a7705874f92f322f3d2786"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e46ebb3349c739aefb72e46e599ba839e873be7c6895832452fae8a98cc03b14"
    sha256 cellar: :any,                 arm64_sequoia: "99f72bc88bb4f53d97363274bb8bcfc79c68118de466d196c53a1bee8e83ec46"
    sha256 cellar: :any,                 arm64_sonoma:  "50b60c8bf9b48ddc08cfbb231447c673c07cafe6c288f5b85840066ff15e98df"
    sha256 cellar: :any,                 sonoma:        "4292b469228b414ce35c2e9865b6c4cb3719e86157c69a20520c5501ff352cab"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0dc09e461ff101bfc369e8b3893d5ee572a50399021f8a1ad47d21a133f37e82"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6f443a8ddf7a9be0000815894c26e91d571e8147b295ea15122cea7de051fa0a"
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
