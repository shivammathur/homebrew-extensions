# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.4.tgz"
  sha256 "41eead0799cc66876b12d10b5efe86268bfc704c1be57a70d49e4bd4bf6c8ee1"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "781b617fc9d28058122ff65c7bd1cbce9068adeb0ab9d836619b4686381f4f68"
    sha256 cellar: :any, arm64_tahoe:       "46405743a50af2ae70127063171f92e5d1704471b4bfa054ba048628b9dfda7c"
    sha256 cellar: :any, arm64_sequoia:     "5ca003214665b21429564a42c6b4bf16088c1d4b59b27abeddc6bfbb594a732f"
    sha256 cellar: :any, arm64_linux:       "b464e63230bfe574acc81131de17631e1c783f411a4ea1e9f6f133600dbab1ed"
    sha256 cellar: :any, x86_64_linux:      "863efdde32f0ba219935611bdd98bd7f68236bacce8f2be6aa59727aa79ea2cc"
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
