# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.2.tgz"
  sha256 "7d47d1e92c754ca3999d0671b0c4b71878787d65de35f3b0e8c14f6345476ad9"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "03f742e3193154ff9f12e57b24641161f8dfd3154285d5dfeb8210d7d0616a8c"
    sha256 cellar: :any, arm64_sequoia: "da722dc88eafaddd32e4653fe08e4767fb1a2a99fb78b89fec5c057bc8459277"
    sha256 cellar: :any, arm64_sonoma:  "d184ed48f8bc09f9a0ba8b24c372b91cf4edffc62cf04ad5fab0122329fc4c22"
    sha256 cellar: :any, arm64_linux:   "caf8886abc6a59fe99e4fe79ff65dd39437f4e945a12f916bfb1e8cdda7963e0"
    sha256 cellar: :any, x86_64_linux:  "e290e2b97263bd2a4a7ed5f153ded9b7f58eec211b75f42f92bae032db45b4c2"
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
