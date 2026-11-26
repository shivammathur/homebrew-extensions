# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.9.tgz"
  sha256 "9ecf4f6005e1adbb0e5c59c55ff2e9c8347983060aac472043ee3b8570e816f3"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "dbbaec54bab6ffd59c37466c0632a3365ef38b5a50dbcacc72511a38a7ae5579"
    sha256 cellar: :any, arm64_golden_gate: "de3829712b8686c8d365bfb66fc2dba52a5f8ee55ccb4d7ec857a8f150aeb49f"
    sha256 cellar: :any, arm64_tahoe:       "a827d35d446ca24e078c0fd4996d46f23bb91aa65b0890e5d956dcac8bc5d41f"
    sha256 cellar: :any, arm64_sequoia:     "a31bf762910d79fc5372d11d11e99e251a2d7a2733e3725b37f03f8b19502dd6"
    sha256 cellar: :any, arm64_linux:       "68b00fbb2352302903c1ecf28ff76971290b1e4293392a88cedc21628d83f78b"
    sha256 cellar: :any, x86_64_linux:      "06f44fe289e5d962efe062e4ace063d0f40924bee6d7805818910cd35f8d305f"
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
