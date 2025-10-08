# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "1556855306a9b67408a49bd227ba0831bc2aedabbeb2fb00b1e50d9043b90903"
    sha256 cellar: :any,                 arm64_sequoia: "45fb29b525488a2ff5baf2445a8ae19cacced8632ede2713e908fdb2296fe549"
    sha256 cellar: :any,                 arm64_sonoma:  "029e4cafed87e0e287cae425bf6f185a8e0c420f6cb0871d2eedc0f936afb8df"
    sha256 cellar: :any,                 sonoma:        "e715cb0b604aca249623b454cbe398ad63ad9fffaba0fefc182d548a0aede633"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "064bd93a1650a1b69b93870a53f7e102d7d1f56db175f5b7ca5a30896ec347fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "06906a8c5b97fac8c9b6b492d0366e9240127eddbfabe4127ade17f5952acf3a"
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
