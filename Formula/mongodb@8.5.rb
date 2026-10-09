# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.4.tgz"
  sha256 "41eead0799cc66876b12d10b5efe86268bfc704c1be57a70d49e4bd4bf6c8ee1"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "670303dce96cf9bbe1053751b0a5bc266f2c6d868f36f7b170eae6ecbed15220"
    sha256 cellar: :any, arm64_tahoe:       "b474f0d0ae70eeaa58728612cf695364ba08f1294ca7a9ce245d66a1a1e9f917"
    sha256 cellar: :any, arm64_sequoia:     "be36e08d5bfbc814eae9caf812413b6028d6393b390b8a8a17a4990f816cb353"
    sha256 cellar: :any, arm64_linux:       "b1ed5c21af68283e375b6a4257876b440d0d33d49917266c1b2a64aa998daa7c"
    sha256 cellar: :any, x86_64_linux:      "3a2a7a27cc5976d803009412db9da26da0d838d9fb6f285ecdd85df1d4fe6ca1"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
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
