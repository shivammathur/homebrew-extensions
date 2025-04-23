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
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "ede71773d2b6eab3e611f5bc12a1735e1fe8da31ec86b7fc5b12afdf682735e7"
    sha256 cellar: :any,                 arm64_sonoma:  "3cd5de4aa7425f63936729318185464fed550be5e7427be5038af4f95725c786"
    sha256 cellar: :any,                 arm64_ventura: "b54edc5e3a54d775070630fee2d7a63c746766d973fd116eaa51e6b9770fd4a2"
    sha256 cellar: :any,                 ventura:       "771f9296e8134e918b0b7d316afc1fec98dc7d35fb92dd9c66a08d1e5d0dcc5d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "04bf3cea2fa4afe03d1b995d783bd1b0ca4c9c5a3dc35e88582a0d2248ea752f"
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
