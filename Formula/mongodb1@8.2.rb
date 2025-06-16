# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.1.tgz"
  sha256 "357e1f4f6b9f6f6970789f5186467da1960dff2db2a8d6474f69ad51a37b5f72"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "b91bf4f33326c341ecad0a473275ac33070f4439b74692e1dcfcd1e31dd8ccdb"
    sha256 cellar: :any,                 arm64_sonoma:  "ccd65a4a5b96dc1f264d2add7c03a48fa5c9492ec76bdc57ecc8258b9975a3ea"
    sha256 cellar: :any,                 arm64_ventura: "6fc989a2770856b666d8661c235f775d5e434993df787914a109efe5aeb86bc5"
    sha256 cellar: :any,                 ventura:       "a316b42cf8c689e5ea113af9194523baa4471cfd457672d109d096eb02d520f8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "539a515d28db35f5a9bbe128d376850abe0d385fc6f9f4676b577570e6429c0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "803b723cca4547fb72d03b1d8ade6f12ccc44c59b666d8e6b93e578d23362921"
  end

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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
