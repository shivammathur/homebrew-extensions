# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "9ef3e172aa332dd9ebbe40733d9041a03b27120d5f7dc162cc7654ad24b1e0e7"
    sha256 cellar: :any,                 arm64_sequoia: "08899a49529dbf100b644a64fef22c077c3ee87ba9102296056a6b466f5167ed"
    sha256 cellar: :any,                 arm64_sonoma:  "1a21334a1a4d10701827ee2cd52cb17c8765e1c240f6963680d1938456786840"
    sha256 cellar: :any,                 sonoma:        "e76fb0a9c8a55f7716daa844cc7457e580411e8c872352110f11ce9164d9be60"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9c42b3a4212dd5c89be78cb33f445251f7c99a5435e8b4bd530124d3530c5d88"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0752a375aa1638b29a6617da79c8b762e581d3d6073a864140eecf6ab00bf345"
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
