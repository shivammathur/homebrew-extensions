# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.3.tgz"
  sha256 "370ff9c06932139c69f6b4c57b1a97c95b0278d3baf23fa42b8fb571ddb92bbf"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "012b9c5db619d6395688f5fb70fd530523776d501f3c89dd8803eace04f21c31"
    sha256 cellar: :any,                 arm64_sequoia: "ba3c9cd65dfed6062ac12a51fea08a4b2e689283fe914bc8dc3aee561f97702c"
    sha256 cellar: :any,                 arm64_sonoma:  "e7c9773558adee521916cd754d274b57909c83b6dc03814093cf2037961b1946"
    sha256 cellar: :any,                 sonoma:        "bdd57e0aad91c0093a3584199276ba7dd70c9d9b2d11502c2dbc8b65f12aa5c5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "86fced0d56dce777eeea5d0d05d67b59fa5311bfb4ce97121bfb2710534b6452"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c9fe5f2469e4b2745cc3fd04283d1e24c0eb4847e13e8424f480e8f56f31707"
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
