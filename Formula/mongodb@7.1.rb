# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  revision 3
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.11"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia: "477871542135c645cead57c112230e601827f00da73f2593522145b6fccca513"
    sha256 cellar: :any,                 arm64_sonoma:  "2eae8f1ce26cb863e4e127a5cb3957eac2dc5ecdd364b64cd1600f56f05c0f4a"
    sha256 cellar: :any,                 arm64_ventura: "6f9fafce5dc4f5a6e8ffabf76a564cb6c813f77a0392284ab8558fe58f653a54"
    sha256 cellar: :any,                 ventura:       "19e3675ceca9a0079a2823e99150a39aa0073b11559aaa3583704d164fa83f0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8ae7ea62056cb3163ef4589225bcd26252f11df7461e1759762a86dd0bb3569e"
  end

  depends_on "icu4c@77"
  depends_on "openssl@3"
  depends_on "snappy"
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
