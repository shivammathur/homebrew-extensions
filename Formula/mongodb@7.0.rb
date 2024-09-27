# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT70 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.9.2.tgz"
  sha256 "95e832c5d48ae6e947bdc79f35a9f8f0bbd518f4aa00f1cef6c9eafbae02187d"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.9"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "67c13ae7e560a8e1179b0f850fccf05bfd660e897f5ee5c63beff9e1175c04b6"
    sha256 cellar: :any,                 arm64_sonoma:  "5375b602ebbd37928d817cdf1bc2953fd06fff17b1930023c2eaddadd67cf67f"
    sha256 cellar: :any,                 arm64_ventura: "21d29bfd11f3d254310c0eada149aa6c43de0ea0c9b2ef955dd820c1ec17715a"
    sha256 cellar: :any,                 ventura:       "4d952ff2b302fcd12d4e5dce53d7db017897dd107f3995bf4f470fdb7a6b578d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "188beca568752a3ba2ce844c80249af9a61bc81ee4b01cdb35e194f21ef61594"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
