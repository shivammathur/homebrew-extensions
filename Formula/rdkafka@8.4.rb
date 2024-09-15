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
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "d6e86aaa045de4445897505f6b8fd8306888de467287ee6703071cd07cdc2349"
    sha256 cellar: :any,                 arm64_sonoma:   "417a1ebd991f2d34d62de0f472c359678e2857b44d98f7dcb65273606113cc41"
    sha256 cellar: :any,                 arm64_ventura:  "b4c9b529b36ed06559ede358487258f901b852f03bfd961b38040d040b77f6ca"
    sha256 cellar: :any,                 arm64_monterey: "2ff86ba2f44deab43fa56739c49edc66020564c01df4216ddb0f659e6cbe6ecd"
    sha256 cellar: :any,                 ventura:        "900956c9abb314c602d60e22ed9a6d08f46307368607ef41d8f3ea72e4dfe6eb"
    sha256 cellar: :any,                 monterey:       "3677981b89a50e63cc844b3da898f519650d133f11e281fbd7cd1950bbb15ce4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5d6ea482cc15d86f1c1600f7487a2db360ba4234fd27baa9c4869c3b4c187798"
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
