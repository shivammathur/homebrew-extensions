# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.0.tgz"
  sha256 "7e7c4fbdc991bad24524316096d4ac9cd805632c9ba7f9886682db843d60166c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "be95a3e9c4b423a0d21ce052c39e1cd4ace573198de0d1dfdac9213af823bcb4"
    sha256 cellar: :any,                 arm64_sequoia: "fdef4d4f08827afe2e5d625c7cf2707a8b1b162f1ca720547c4f37bae9551762"
    sha256 cellar: :any,                 arm64_sonoma:  "b7a17515d71fae89980dab2932ddee0385455f8a54f201a3140ccb6beaf84803"
    sha256 cellar: :any,                 sonoma:        "a616cdbf8356f91e706f4b0cbca12cb674abc749a87abdf5de323a174a94f05b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c60da4b810ff2f6cb1e122904102453c8d990dbc14ef2dff4ef9ed3cb7ece5fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fc451002473efb48474f48997316d4f97efc6b8e8d40be320a3b46e22a2e957e"
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
