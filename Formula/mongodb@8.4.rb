# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "a0b7c5764563bb0d0f8ab4b521a7b7f2d235b5d163102a5dd1ca0fa4c98f806d"
    sha256 cellar: :any, arm64_sequoia: "6cf98dd80e6dbf0372edffe1c0f643b34fabcadffb531d3d0c608e095e72865d"
    sha256 cellar: :any, arm64_sonoma:  "553b1fcd82d90732573d5ba69c63f3f8e5cb966a34ce28ae6463b63649f43c3d"
    sha256 cellar: :any, arm64_linux:   "9b88a5967ebec98d9d9c3143a7c0155d47adccb2a75bbf147ac735b2166e606b"
    sha256 cellar: :any, x86_64_linux:  "1c88ec022af42097d3e55d9478d2147813095c9da9e706edd0b08f6d76816221"
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
