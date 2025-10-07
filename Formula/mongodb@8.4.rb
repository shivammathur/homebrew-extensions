# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.3.tgz"
  sha256 "6ef901d143a739c0769fad5b1bcd92646baa094d532e43738b48a13039ab067c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a87821ad07a3c0a1739eb9978153cfbe34682b5e47924f3eff0e3c7911c6deeb"
    sha256 cellar: :any,                 arm64_sequoia: "7589ca4f13c9df8a0f0f56b3295dace2d97515f63773bfe7a668b5184af59925"
    sha256 cellar: :any,                 arm64_sonoma:  "fc76d4b2e6b1aa7623a7dcbabbb42fd8bc6a99f2eb783edea640cc9ebf990711"
    sha256 cellar: :any,                 sonoma:        "09b5bc7784f517839099d773384c3606563b41dc845befebd14a87a3eb24a983"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8cdeb1f545b9afa8be4726bedf052dedcfee0dbdbc270b403d40506099dac3be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "98768fe15f0b0b23287d25278290d090dbc4f853b1b82b6c886b7a15f5f90526"
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
