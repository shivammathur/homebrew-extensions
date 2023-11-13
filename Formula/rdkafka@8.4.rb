# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT84 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "ddae3030b637cd80d79c5299d9a39e8d6d4591bc66d945fce47d2f2960cd0cee"
    sha256 cellar: :any,                 arm64_monterey: "c8a49eb11c8f8f30aead1eae2864006eb4f47be511e802c7aee02ed06d154cf0"
    sha256 cellar: :any,                 arm64_big_sur:  "877025c9a6caf5dda45d13b0fea3d9020732f893a1e773d8a289e3da9a81e16c"
    sha256 cellar: :any,                 ventura:        "2ca7fccc54bb52586ccd3a9849bcd90588f26a6e89eeca99a8bed770cafa67fb"
    sha256 cellar: :any,                 monterey:       "acaad91d958070d605c1eb09b6987827dd21291ae13e0ed72c1cd4df301c3e7c"
    sha256 cellar: :any,                 big_sur:        "383eb677436ce831ce329b4a61131f294ee3294ed922d4e8f4522b98c03c06fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "486e1d955474fb8169ea84dbd1d162d10d644604a931753baadbcae0cf006142"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
