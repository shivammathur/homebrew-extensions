# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "29ba03821da5850d566adaaeef12a0023039de831ba0430f11d83d53b0931565"
    sha256 cellar: :any,                 arm64_sequoia: "82e3618c77234090055fca38e026770bfdce8410ef46afacef2820b81961a54f"
    sha256 cellar: :any,                 arm64_sonoma:  "b3af9bab0999e38740a0945dd42f27225a0fa274ffb4d863173aebf7f8e6d259"
    sha256 cellar: :any,                 sonoma:        "d676f983b2ddbffb5212c01a56215bf2624f680478cb82d478f7ad1e88acf824"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8130e600de558a2df60970d3b360838e0c222d0fd1f103660e20260cdea3c751"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f36cbb6fd1daf5d123403ede4dc312e872240d615c2748ac951a4f6f12adc00b"
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
