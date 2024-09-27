# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "f84c1b8c89951ba77008de7bcb6e9d3adab9f2c824b1e8186a9d360fdda53295"
    sha256 cellar: :any,                 arm64_sonoma:   "aa5e210df710eea86579075b118c1ead2545a32fb132bf87064e0a616d2fadc5"
    sha256 cellar: :any,                 arm64_ventura:  "17b34d11482689dd490392c47893f6106af883e9e3ebc2fc7e785b8809a35159"
    sha256 cellar: :any,                 arm64_monterey: "e5f6f7c38386ef879ea08410572f3f64ea7c6790182f44c09438a3d915aece8d"
    sha256 cellar: :any,                 ventura:        "793855634d7e1c1cd49c3a3b578cc6f16ebab3634eb09d6ab82e40af65e6fad2"
    sha256 cellar: :any,                 monterey:       "90d7c36af16080996e11d9d12b736f76998307d3cf1d4d25f7e27f9c3d78952b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1cd430d86e96f012dba9a5de9a242b60da8582d5644703f9f69182d0bde3fea9"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
