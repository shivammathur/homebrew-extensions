# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.2.tgz"
  sha256 "df01e7c41166fd068558977e390623061b3ef626e056b0fb4edb4d816021569c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "315d2817fcf5abae28e45aeea4800cf5261c555a35da5eb0b13fe35bb2d24f78"
    sha256 cellar: :any,                 arm64_sequoia: "3725798ff7358334045e271199db2e47f99568436ef57927d6fbaf40080629b8"
    sha256 cellar: :any,                 arm64_sonoma:  "11588f611dfac70461a742b1e6bbb43edcd3e90b6be0a1f286f44ca98416dc1b"
    sha256 cellar: :any,                 sonoma:        "5fe271f543ba478ff91273c5413eafd3d2bc01f8a62ac7a16399177b978e86fb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "35fa89014961a4627e1653570a21526b0ccc9b6e00c3e7c1ebfde6e8bd52089e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0d189a52687c42af668f6e6fdb69767060d0104f66077249f93c4771b43b1214"
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
