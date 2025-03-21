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
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "fb53bb0ceb8ce5d624587bbe785416482caebc583a5cbf6a873f5157f8c2f1fc"
    sha256 cellar: :any,                 arm64_sonoma:  "8eee2b821259948040f46a00e9f3cc51a01f2e116b381d7394685f53280d4909"
    sha256 cellar: :any,                 arm64_ventura: "d11d1ee2842fa9aaaddc2d6fcb6aeea55c5bd128d6b199d830e7a76433bbcace"
    sha256 cellar: :any,                 ventura:       "e9ba95cd86f4878c63ade5ceefa39a78bd6072532b2b0155306f9c897dd9b81b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "77126f984dd9ac171914e1996470a013f7728736f6808e36e28ab0f27aff8204"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
