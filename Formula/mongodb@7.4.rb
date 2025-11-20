# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.1.tgz"
  sha256 "614e57594918feb621f525e6516d59ce09b78f5172355ba8afb6c2207c1ce900"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "9b709ab32667a159e2d1c9fd0daa8bf3755d0b9bb06bd94a894a95a46c308aaa"
    sha256 cellar: :any,                 arm64_sequoia: "760e08d71108ddbc97ee4cc5e33a5fbe224f1bc2920609bd8a0bd60fcf33115f"
    sha256 cellar: :any,                 arm64_sonoma:  "5ca809f6997255ba2df6c4d9453887b408a07aeeaacbc8daf9b2b4b56d924e7e"
    sha256 cellar: :any,                 sonoma:        "da9d9f9743480ae7936e64a93a27c12794a6c662b556b324e2abc4018522465f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5156af8ad085074aafe8c1c7609ac8169078c965d7afc2723e61dab27a2b819a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ffa785bb75fbebabd7dc4a5d871660210dbeb4dfd0f9ecdc7740a3971565b7a5"
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
