# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "fc530d4a1c6f758140608f259588b2640c2e9c52c2f4990e3e66001135ac213f"
    sha256 cellar: :any,                 arm64_sonoma:  "03cdb0f2180c937500625fe0a1c169fba34a44559e4259217296bbb5fbbb17dc"
    sha256 cellar: :any,                 arm64_ventura: "60bd0fcf36d9e691be3b74abde42686b73bd104944a4518ea0a4e85f712a25fd"
    sha256 cellar: :any,                 ventura:       "7a3db74a2a33f50730631745246f814bd0721f1ef246882af3163bd55e8f5719"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3c80b93fe46dac8f1da39f76341a3e60a099aad32137a30672d2b7d870b76450"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e671d8a8615543548d90f6a9a77fe4645769f719d7fdc9a8378a898c63c969b8"
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
