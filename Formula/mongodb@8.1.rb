# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "5be018faf5def49eea0daae74a0ef718b7777724f446e04ac5d873aaeaeffea7"
    sha256 cellar: :any, arm64_sequoia: "4c74122f94229ea6b6578bb251a51fac4052fc8fcc1dd84d788f4a2edb2b2512"
    sha256 cellar: :any, arm64_sonoma:  "20412c869c7d1e4e631164d4541568aa636cc816e6e4e6a43955a2f405cd4920"
    sha256 cellar: :any, sonoma:        "77f95fb16a8e0fe9a83723b4740ead98406650b0a4be1aea59c3900d24dc4fc7"
    sha256 cellar: :any, arm64_linux:   "1217e32707abeb3cdb48ebedd1c30ab7713abee3375732e75dde7251f74ac408"
    sha256 cellar: :any, x86_64_linux:  "b1cef271c928185cdb88febbb92d9bb2b5406f04b3d303b4549a0e4e17856650"
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
