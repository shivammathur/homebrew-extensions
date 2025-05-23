# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.0.tgz"
  sha256 "2717abd81cdff4a1ed1f08d9f77d9c3601a9d934e89bc5441617f7c0acd62d17"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "245355e356afc85a9bbb5865b169dd5a32ec163a1a2ec42c1e42370ae6c0e26f"
    sha256 cellar: :any,                 arm64_sonoma:  "b2364ab2849fbc9b96f367c645999048db596a8fcc47b1e689f0cb85cf738851"
    sha256 cellar: :any,                 arm64_ventura: "2e49e9fc4d68bdd9c39abebe05f35e91e84c37a693b86615ed760f9541791307"
    sha256 cellar: :any,                 ventura:       "edeaf9ceb998a3c348db9d28197fadefe8259ad7d56efad9b3fa849ace72425f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ca159bb84d02d400eaf1b82a7656857794a7455cc1498e583ed4a704349aa809"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
