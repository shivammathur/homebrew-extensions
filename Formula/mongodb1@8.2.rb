# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.9.tgz"
  sha256 "05045ef555d042991c6991d4439b85ebcaee5698f3733516f656508131d6e6c3"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "bf146549933cba41488be93297c891da20dceb1f99dd6fff3849f05b82adfc61"
    sha256 cellar: :any, arm64_sequoia: "83014977524609d588961ea800bcf1c4cf035b1a4249ad341f0140cbc24d95f5"
    sha256 cellar: :any, arm64_sonoma:  "22dec630cdbbd9359e1b62fcf2569cfc0e64fc70973cd5df0b168af47df384d4"
    sha256 cellar: :any, arm64_linux:   "a13b94f9f495225c3b9b39844dcaf5aa7d7bfc0960b0ea0c4a8a7f5dbb659bc4"
    sha256 cellar: :any, x86_64_linux:  "ac562a55a10bbd4524e958396a1f9fb7ed7065c569df4ff2b215be0864d1efd2"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
