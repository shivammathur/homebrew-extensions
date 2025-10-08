# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.2.tgz"
  sha256 "68547dcfb05d424c5bcb82d20fa4c41a5672aacf9953e6f301c89a4830f78db2"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "ed6f4729c0751e4a8919cdff3a1468a0f16c8b91d9ac7c80b0f7621c92a7150c"
    sha256 cellar: :any,                 arm64_sonoma:  "49dbadb53f40c89497b0af2547367b081ae0c098017583cfaf2691f8488b53a8"
    sha256 cellar: :any,                 arm64_ventura: "b0e68567ba5f637b0689bb5bfce34c5254867435272658d111ee50f650221862"
    sha256 cellar: :any,                 ventura:       "d64a0a0c721cb9831625db51e89d35934aedc32d0c2df38bcf7b803cd4a8c689"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "65c14a723f76af381c2fdedf9750d4b54d5926ff3c470fb6395056ef0af54ee0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "af844090d17bb21849c85818a63a8411137f432f97c63d4b577a303401481f92"
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
    inreplace "src/contrib/php_array_api.h", "IS_INTERNED", "ZSTR_IS_INTERNED"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
