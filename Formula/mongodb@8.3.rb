# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.0.tgz"
  sha256 "532b8408978a3b7a0aa4abdd7b33699ccbf94c312e7fce38da408b787006c08f"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "790322dd3407bc57804e825380bace7482acfd7b7bed8e93ac67a23439eb92c1"
    sha256 cellar: :any, arm64_sequoia: "97355a61fe8d2e421899befc7f79b09e166f94b6034b576f3d060837a3e6c85f"
    sha256 cellar: :any, arm64_sonoma:  "10dc9602bb1d6a057be6a1833bd87b31ab0ad62947f04f1a6cfc272cf51a3eae"
    sha256 cellar: :any, arm64_linux:   "0d812b4478dc133d1b5460116666a62e8b192b01eeb0fa77abe600f6ff6be57c"
    sha256 cellar: :any, x86_64_linux:  "a24df864ae75e835e1a6e88c588c7acf60790c3702205da5a8827450e1fa1a66"
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
