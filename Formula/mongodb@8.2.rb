# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "bf4839f59e74dbae910dc4d65b37d35bb1ac3219c4082577124aaf6e3892ca6a"
    sha256 cellar: :any, arm64_sequoia: "877b6fb161e4180e1ae625c64f1290df13302719ee22697fb050cbaeed21b280"
    sha256 cellar: :any, arm64_sonoma:  "c8ea1b7d9c3b686c776ee71996a8b42403a4f5fcd387d1feedc798056e987eb4"
    sha256 cellar: :any, arm64_linux:   "3cf59736525cf2bea5ccbc901d0cdcd840144b021b5df686f9ef8e3b57a8b1fb"
    sha256 cellar: :any, x86_64_linux:  "c98246fa1219208e7a59360f6b8ce19b638854b446fbf4e63931c31c40eb1473"
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
