# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT70 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.9.2.tgz"
  sha256 "95e832c5d48ae6e947bdc79f35a9f8f0bbd518f4aa00f1cef6c9eafbae02187d"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.9"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "41c37168e28580142fdc127ec99f613730b1b55bccbc915e235681d95f6c476c"
    sha256 cellar: :any,                 arm64_sonoma:  "8fd9cb5fe1806f82d247d8097a520e8335de8273cbca05e90b466d80e830b9dd"
    sha256 cellar: :any,                 arm64_ventura: "74ac8fe0a9a21ebc3cb45da0ed91a6c27b7ba5dad9a3bd8ec5b17d57052397ab"
    sha256 cellar: :any,                 ventura:       "9de2e619e887042228f40ba9813d6f1f3b77b1d56cc52036f6978eacdea0eddd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a368d1814a3e371e4b55b54243727dede8a9cabbf8c77496702f7215eae16f81"
  end

  depends_on "icu4c@76"
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
