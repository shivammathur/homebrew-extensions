# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.4.tgz"
  sha256 "a5d09090fec30f1a8c26d0ea2f2b36583e1a2ca2b74754a3aad9753193a2a5e1"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "3cb353e043ec515a061c293a4ce4cce19aabd4c2e87e63140626c48b90ffe573"
    sha256 cellar: :any,                 arm64_sequoia: "58f3e88c4996fd570cc76ffa9547ad05113c6631c64c983fb180113a2f339d76"
    sha256 cellar: :any,                 arm64_sonoma:  "1ecad079784f8690e260a9efcea207e3b62f451706bcafa58539f7d99807da3f"
    sha256 cellar: :any,                 sonoma:        "284dee2469f5f16d2c79155416dedad332b203654ec8e31a8dd0721f3c4ee4db"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cdf0c6a14b6a9d49c3aa9f09d0a40bd7306b221c3e16aaac48397c9d6e864cad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "34ab29a9b411f9e3d829070b4f1f5de98fa82e81bc373f7872c4ceb214ceafe2"
  end

  depends_on "cyrus-sasl"
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
